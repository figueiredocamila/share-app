import android.annotation.SuppressLint
import android.app.Service
import android.content.Intent
import android.location.Location
import android.os.Binder
import android.os.Bundle
import android.os.IBinder
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import android.content.Context

class LocationService : Service() {
    companion object {
        fun newIntent(context: Context): Intent {
            return Intent(context, LocationService::class.java)
        }
    }

    private val binder = LocationServiceBinder()
    private var locationCallback: LocationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            locationResult?.lastLocation?.let { location ->
                // println("rodooooooooooooou")
                // Aqui você pode fazer o que desejar com a localização recebida
                // Por exemplo, enviar para um servidor ou atualizar o estado do aplicativo
                // No exemplo abaixo, estamos apenas imprimindo a latitude e longitude no console
                val latitude = location.latitude
                val longitude = location.longitude
                println("Latitude: $latitude, Longitude: $longitude")
            }
        }
    }

    private lateinit var fusedLocationClient: FusedLocationProviderClient

    override fun onBind(intent: Intent?): IBinder {
        return binder
    }

    override fun onCreate() {
        super.onCreate()
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        createLocationCallback()
    }

    @SuppressLint("MissingPermission")
    fun startLocationUpdates() {
        fusedLocationClient.requestLocationUpdates(
            getLocationRequest(),
            locationCallback,
            null
        )
    }

    fun stopLocationUpdates() {
        fusedLocationClient.removeLocationUpdates(locationCallback)
    }

    private fun getLocationRequest(): LocationRequest {
        val locationRequest = LocationRequest.create()
        locationRequest.setInterval(10000) // Intervalo de atualização de localização em milissegundos
        locationRequest.setFastestInterval(5000) // Intervalo mais rápido de atualização de localização em milissegundos
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY)
        return locationRequest
    }

    private fun createLocationCallback() {
        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                super.onLocationResult(locationResult)
                locationResult?.lastLocation?.let { location ->
                    // Aqui você pode fazer o que desejar com a localização recebida
                    // Por exemplo, enviar para um servidor ou atualizar o estado do aplicativo
                    // No exemplo abaixo, estamos apenas imprimindo a latitude e longitude no console
                    val latitude = location.latitude
                    val longitude = location.longitude
                    println("Latitude: $latitude, Longitude: $longitude")
                }
            }
        }
    }

    inner class LocationServiceBinder : Binder() {
        fun getService(): LocationService {
            return this@LocationService
        }
    }
}
package com.codelab.flutter.admobinlineads

import android.content.Context
import android.graphics.Color
import android.graphics.PorterDuff
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

var adsChannel : MethodChannel? = null
var buttonBackgroundColor = "#f6546a"
var buttonTextColor = "#ffffff"
var headlineColor = "#000000"
var bodyColor = "#5b5b5b"
var adTagBackground = "#ed6f65"
var adTagTextColor = "#ffffff"
var starColor = "#2fd696"

class NativeAdsFactoryMedium(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.medium_native_ads, null) as NativeAdView

        with(nativeAdView) {
            val adTagView = findViewById<TextView>(R.id.ad_text_medium_ads)
            adTagView.setTextColor(Color.parseColor(adTagTextColor))
            adTagView.setBackgroundColor(Color.parseColor(adTagBackground))
            val mediaView = findViewById<MediaView>(R.id.ad_media_2)
            val media = nativeAd.mediaContent
            mediaView.mediaContent = media
            this.mediaView = mediaView

            val headlineView = findViewById<TextView>(R.id.headline_medium_ads)
            headlineView.text = nativeAd.headline
            headlineView.setTextColor(Color.parseColor(headlineColor))
            this.headlineView = headlineView
            adsChannel?.invokeMethod("PassAdsData", headlineView.text)

            val bodyView = findViewById<TextView>(R.id.body_medium_ads)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body != null && nativeAd.body!!.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            bodyView.setTextColor(Color.parseColor(bodyColor))
            this.bodyView = bodyView

            val ctaView = findViewById<Button>(R.id.cta_medium_ads)
            ctaView.text = nativeAd.callToAction
            ctaView.setTextColor(Color.parseColor(buttonTextColor))
            ctaView.background.setColorFilter(Color.parseColor(buttonBackgroundColor), PorterDuff.Mode.SRC)
            this.callToActionView = ctaView

            val attributionViewLarge: TextView = nativeAdView
                .findViewById(R.id.attribution_medium_ads)

            val iconView: ImageView = nativeAdView.findViewById(R.id.image_medium_ads)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            }
            nativeAdView.iconView = iconView

            val stars = listOf<TextView>(
                findViewById(R.id.star1),
                findViewById(R.id.star2),
                findViewById(R.id.star3),
                findViewById(R.id.star4),
                findViewById(R.id.star5)
            )

            var starRate : Double = 5.0
            if(nativeAd.starRating != null) {
                starRate = nativeAd.starRating!!
            }
            for (i in stars.indices) {
                if (i <= starRate) {
                    stars[i].setTextColor(Color.parseColor(starColor))
                } else {
                    stars[i].setTextColor(Color.GRAY)
                }
            }

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}

class NativeAdsFactorySmall(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.small_native_ads, null) as NativeAdView

        with(nativeAdView) {
            val adTagView = findViewById<TextView>(R.id.ad_text_small_ads)
            adTagView.setTextColor(Color.parseColor(adTagTextColor))
            adTagView.setBackgroundColor(Color.parseColor(adTagBackground))

            val headlineView = findViewById<TextView>(R.id.headline_small_ads)
            headlineView.text = nativeAd.headline
            headlineView.setTextColor(Color.parseColor(headlineColor))
            this.headlineView = headlineView
            adsChannel?.invokeMethod("PassAdsData", headlineView.text)

            val bodyView = findViewById<TextView>(R.id.body_small_ads)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body != null && nativeAd.body!!.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            bodyView.setTextColor(Color.parseColor(bodyColor))
            this.bodyView = bodyView
            bodyView.clipToOutline = true

            val ctaView = findViewById<Button>(R.id.cta_small_ads)
            ctaView.text = nativeAd.callToAction
            ctaView.setTextColor(Color.parseColor(buttonTextColor))
            ctaView.background.setColorFilter(Color.parseColor(buttonBackgroundColor), PorterDuff.Mode.SRC)
            this.callToActionView = ctaView

            val attributionViewLarge: TextView = nativeAdView
                .findViewById(R.id.attribution_small_ads)
            val iconView: ImageView = nativeAdView.findViewById(R.id.image_small_ads)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            }

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}

class NativeAdsFactoryFullSquare(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.full_screen_square_ads, null) as NativeAdView

        with(nativeAdView) {
            val adTagView = findViewById<TextView>(R.id.ad_text_square_ads)
            adTagView.setTextColor(Color.parseColor(adTagTextColor))
            adTagView.setBackgroundColor(Color.parseColor(adTagBackground))
            val mediaView = findViewById<MediaView>(R.id.ad_media_full_screen_square)
            val media = nativeAd.mediaContent
            mediaView.mediaContent = media
            this.mediaView = mediaView
            mediaView.setImageScaleType(ImageView.ScaleType.CENTER_CROP)

            val headlineView = findViewById<TextView>(R.id.headline_square_ads)
            headlineView.text = nativeAd.headline
            headlineView.setTextColor(Color.parseColor(headlineColor))
            this.headlineView = headlineView
            adsChannel?.invokeMethod("PassAdsData", headlineView.text)

            val bodyView = findViewById<TextView>(R.id.body_square_ads)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body != null && nativeAd.body!!.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            bodyView.setTextColor(Color.parseColor(bodyColor))
            this.bodyView = bodyView

            val ctaView = findViewById<Button>(R.id.cta_square_ads)
            ctaView.text = nativeAd.callToAction
            ctaView.setTextColor(Color.parseColor(buttonTextColor))
            ctaView.background.setColorFilter(Color.parseColor(buttonBackgroundColor), PorterDuff.Mode.SRC)
            this.callToActionView = ctaView

            val attributionViewLarge: TextView = nativeAdView
                .findViewById(R.id.attribution_square_ads)

            val iconView: ImageView = nativeAdView.findViewById(R.id.image_square_ads)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            }
            nativeAdView.iconView = iconView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}

class NativeAdsFactoryFullLandScape(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.full_screen_landscape_ads, null) as NativeAdView

        with(nativeAdView) {
            val adTagView = findViewById<TextView>(R.id.ad_text_landscape_ads)
            adTagView.setTextColor(Color.parseColor(adTagTextColor))
            adTagView.setBackgroundColor(Color.parseColor(adTagBackground))
            val mediaView = findViewById<MediaView>(R.id.ad_media_full_screen_landscape)
            val media = nativeAd.mediaContent
            mediaView.mediaContent = media
            this.mediaView = mediaView

            val headlineView = findViewById<TextView>(R.id.headline_landscape_ads)
            headlineView.text = nativeAd.headline
            headlineView.setTextColor(Color.parseColor(headlineColor))
            this.headlineView = headlineView
            adsChannel?.invokeMethod("PassAdsData", headlineView.text)

            val bodyView = findViewById<TextView>(R.id.body_landscape_ads)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body != null && nativeAd.body!!.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            bodyView.setTextColor(Color.parseColor(bodyColor))
            this.bodyView = bodyView

            val ctaView = findViewById<Button>(R.id.cta_landscape_ads)
            ctaView.text = nativeAd.callToAction
            ctaView.setTextColor(Color.parseColor(buttonTextColor))
            ctaView.background.setColorFilter(Color.parseColor(buttonBackgroundColor), PorterDuff.Mode.SRC)
            this.callToActionView = ctaView

            val attributionViewLarge: TextView = nativeAdView
                .findViewById(R.id.attribution_landscape_ads)

            val iconView: ImageView = nativeAdView.findViewById(R.id.image_landscape_ads)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            }
            nativeAdView.iconView = iconView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}

class NativeAdsFactoryFullPortrait(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.full_screen_portrait_ads, null) as NativeAdView

        with(nativeAdView) {
            val adTagView = findViewById<TextView>(R.id.ad_text_portrait_ads)
            adTagView.setTextColor(Color.parseColor(adTagTextColor))
            adTagView.setBackgroundColor(Color.parseColor(adTagBackground))
            val mediaView = findViewById<MediaView>(R.id.ad_media_full_screen_portrait)
            val media = nativeAd.mediaContent
            mediaView.mediaContent = media
            this.mediaView = mediaView
            mediaView.setImageScaleType(ImageView.ScaleType.CENTER_CROP)

            val headlineView = findViewById<TextView>(R.id.headline_portrait_ads)
            headlineView.text = nativeAd.headline
            headlineView.setTextColor(Color.parseColor(headlineColor))
            this.headlineView = headlineView
            adsChannel?.invokeMethod("PassAdsData", headlineView.text)

            val bodyView = findViewById<TextView>(R.id.body_portrait_ads)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body != null && nativeAd.body!!.isNotEmpty()) View.VISIBLE else View.INVISIBLE
            }
            bodyView.setTextColor(Color.parseColor(bodyColor))
            this.bodyView = bodyView

            val ctaView = findViewById<Button>(R.id.cta_portrait_ads)
            ctaView.text = nativeAd.callToAction
            ctaView.setTextColor(Color.parseColor(buttonTextColor))
            ctaView.background.setColorFilter(Color.parseColor(buttonBackgroundColor), PorterDuff.Mode.SRC)
            this.callToActionView = ctaView

            val attributionViewLarge: TextView = nativeAdView
                .findViewById(R.id.attribution_portrait_ads)

            val iconView: ImageView = nativeAdView.findViewById(R.id.image_portrait_ads)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            }
            nativeAdView.iconView = iconView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}
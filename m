From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: [PATCH v10 24/24] arm: dts: omap3: N9/N950: Add flash references
 to the camera
Date: Mon, 11 Sep 2017 11:50:29 +0200
Message-ID: <3ea79dc9-9374-008f-7cd9-567a560a0fd5@xs4all.nl>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
 <20170911080008.21208-25-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170911080008.21208-25-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 09/11/2017 10:00 AM, Sakari Ailus wrote:
> Add flash and indicator LED phandles to the sensor node.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>

Regards,

	Hans


> ---
>  arch/arm/boot/dts/omap3-n9.dts       | 1 +
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 4 ++--
>  arch/arm/boot/dts/omap3-n950.dts     | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> index b9e58c536afd..39e35f8b8206 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -26,6 +26,7 @@
>  		clocks = <&isp 0>;
>  		clock-frequency = <9600000>;
>  		nokia,nvm-size = <(16 * 64)>;
> +		flash-leds = <&as3645a_flash &as3645a_indicator>;
>  		port {
>  			smia_1_1: endpoint {
>  				link-frequencies = /bits/ 64 <199200000 210000000 499200000>;
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 1b0bd72945f2..12fbb3da5fce 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -271,14 +271,14 @@
>  		#size-cells = <0>;
>  		reg = <0x30>;
>  		compatible = "ams,as3645a";
> -		flash@0 {
> +		as3645a_flash: flash@0 {
>  			reg = <0x0>;
>  			flash-timeout-us = <150000>;
>  			flash-max-microamp = <320000>;
>  			led-max-microamp = <60000>;
>  			ams,input-max-microamp = <1750000>;
>  		};
> -		indicator@1 {
> +		as3645a_indicator: indicator@1 {
>  			reg = <0x1>;
>  			led-max-microamp = <10000>;
>  		};
> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
> index 646601a3ebd8..c354a1ed1e70 100644
> --- a/arch/arm/boot/dts/omap3-n950.dts
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -60,6 +60,7 @@
>  		clocks = <&isp 0>;
>  		clock-frequency = <9600000>;
>  		nokia,nvm-size = <(16 * 64)>;
> +		flash-leds = <&as3645a_flash &as3645a_indicator>;
>  		port {
>  			smia_1_1: endpoint {
>  				link-frequencies = /bits/ 64 <210000000 333600000 398400000>;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Francesco Lavra <francescolavra.fl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Sat, 29 Sep 2012 11:41:26 +0200
Message-ID: <5066C246.1050003@gmail.com>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
	<1348526634-19029-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1348526634-19029-5-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 09/25/2012 12:43 AM, Daniel Lezcano wrote:
...
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 5f809e3..2596422 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -43,21 +43,46 @@ out:
>  	return i;
>  }
>  
> +struct cbarg {
> +	char *buf;
> +	ssize_t count;
> +};
> +
> +static int each_driver_cb(int cpu, struct cpuidle_driver *drv, void *data)
> +{
> +	int ret;
> +	struct cbarg *cbarg = data;
> +
> +	if ((drv && (strlen(drv->name) + cbarg->count) >= PAGE_SIZE) ||
> +	    (!drv && (strlen("none") + cbarg->count) >= PAGE_SIZE))
> +		return -EOVERFLOW;
> +
> +#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> +	ret = sprintf(cbarg->buf + cbarg->count, "cpu%d: %s\n",
> +		      cpu, drv ? drv->name : "none" );
> +#else
> +	ret = sprintf(cbarg->buf, "%s\n", drv ? drv->name : "none");
> +#endif
> +	if (ret < 0)
> +		return ret;
> +
> +	cbarg->count += ret;
> +
> +	return 0;
> +}
> +
>  static ssize_t show_current_driver(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
>  {
> -	ssize_t ret;
> -	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
> +	struct cbarg cbarg = { .buf = buf };

cbarg.count should be initialized to 0.

> +	int ret;
>  
> -	spin_lock(&cpuidle_driver_lock);
> -	if (cpuidle_driver)
> -		ret = sprintf(buf, "%s\n", cpuidle_driver->name);
> -	else
> -		ret = sprintf(buf, "none\n");
> -	spin_unlock(&cpuidle_driver_lock);
> +	ret = cpuidle_for_each_driver(each_driver_cb, &cbarg);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret;
> +	return cbarg.count;
>  }

--
Francesco

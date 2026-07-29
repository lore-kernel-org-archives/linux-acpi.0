Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16441456E0A
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325137; cv=none; b=ZHC+5UiEHZcjhZav+6uLAMxLZI+EPszSG4ujj4pFzfysBXGu41vKYmtYZQ7ss34ARsKuCJdUIIEeRuv8V3bjDrrKNRtvPGXqQ2TdT8i6OLfIZDDtp1sGO+tfi7/G9P5KCrqjXZFHp0sSfadmwEqam9s6Z5gqOEQV4ji+6GS0mIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325137; c=relaxed/simple;
	bh=+bl7W/DghJ2lNo8ihHQByUSlt3smL+/7HO/f5BD68Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu3QIEHzYAVVX02H5EgrfC3aQBe380rBWg54JQ2Yd+8AI7HQIRkBwxpyI7ds4EoLfbXP+GSPrLIXibm7PApDgXmA1Rz+y4UQr+64cEpvuyHO9dNSSseE4gcyyePBiAX3o8hRBTHvenPBR5Fd3io1+dH/HCMvpI9ZDRZvN2OrjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nejlkA2+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nejlkA2+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47db714766aso1184193f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785325133; x=1785929933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5iX3sEVovVYi3DpvUrl6PGylYfhOnizJPhWXlTW0MXY=;
        b=nejlkA2+NzyvGg8tmcTtdNPOQ6J5qEh5WK1TNnNPzsC59uemIEyg3wx/1Gt6LQqKkA
         XbDmwtSrZCz/ASbPdQVAGpH3nJS5kN6K201Vfuh7w1xBbjOOrtGLa1siIui6KVneDaRx
         GWzy4tZobZ8wg47hoEu7QXdAinREusNW1rNZI6oj6Sg4Pz3W9ZelMjdSOXU9pATnJHqP
         Yoml7SIRAX/y5jPEyxytHNrvxfCODisa1A1DARKRBDNlcJ4/SYhNsaooM7E/23Chbta2
         rj47ZtnFpDUUfZ4N5Yw3GtpQ5hUmYj9QhC5CoXEZU7nx2rvn3JiEEjOY5rfWOKWLf5ol
         UJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325133; x=1785929933;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5iX3sEVovVYi3DpvUrl6PGylYfhOnizJPhWXlTW0MXY=;
        b=UYSpBtP9MV6LYhCiB+a8qu2RVbS23NiGMbgGBXblDgq7MbFh7btFlEDBw+GWo9T9Bp
         RDpdhi1PVZ/qXPVSO664RSZ6vw9DWUHiRNOLNEQJcMd/rBh6tHJ9Kv8zARHf3lZU0zP5
         ejxteTcTFuPDlt5lqCg/1xROcdKLQY697TD+cTNOOFg76kDpqeoY0gkKTPegP1XR+nNA
         f9zNyTsiuNev/xhK1ABzCv8UQNCBhZhZ6LEIGolJg4NG9SUZcJ2P0GWrMe2N3Ta7QDoi
         ZxSa82RLI1KRJ1nDV+TXeswZrWaGYonAK4JeniCL7ccByDUA/qkD2NgXfYvg4eNl+RjI
         x26g==
X-Forwarded-Encrypted: i=1; AHgh+RpoNAkiCw7IFB88lkurWc0vfVyzXyN83/dnbxm3Mpn8iJjTAJ7lkKnIuBwjuFKyAVBG8Oly/XZS/Dm1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TFAuyfTFrXJfSrD7moyygcVKnR1bAtIAoI9WWhkZk6q9Oj93
	FO5cwZ+XQ2s/zjRx7vHRmeof0MChq8uWQ2z2YJmUOsZSV6771XVzQCs9PQl9KmAY29Q=
X-Gm-Gg: AR+sD10O2MGh1IUGV2jta5YF4Ox5ubLDhJeJQnF90ruEhDlOw2WqnlvpCx68ItUJRbz
	nEbV0lctveXuP9DInq9GlZQEd15h7nkCC0VVDGv7JOrg6FfIi5n3wGJcwKZA95/FvYzsGhS9LM8
	PVX93Oec9Lfspsq5okx0+w52fFKEg0s9CbsxfCey94KofQNvwWuO/M7jKvbjdUJgcjQJbOw76vZ
	YDIXCWy8CJ/ZT/SG+3VEAgGB00iKr91TVWAU2GTWljkWAwEVdNmDn8Nhx73Q5218fsPtihYC0fw
	69yEnzho1oWLYsajrx+A8XEAEGiGMfAOR3owlFpyH6uf+1KNf8rnxGzWD5rTNBeY3T+HZJvv3rp
	KuBCyXqFa2zJLUZFQF6hHS7lFdk3rNF/Z9Hl7iZ6Lw1R+Uh/Z3C/7vBgo8HaMd7l2gyEX4lk6CV
	61HURQ109IdqbKD7tBinTwquJsNJJZ1hiuLlCYHHwPRKZ5Qv8kJUv1HszGUY2ssLPD9av0gS4=
X-Received: by 2002:a05:6000:2c05:b0:47f:9763:9864 with SMTP id ffacd0b85a97d-47fbabee850mr2432854f8f.19.1785325133163;
        Wed, 29 Jul 2026 04:38:53 -0700 (PDT)
Received: from [192.168.0.101] ([109.77.24.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f039sm7702125f8f.18.2026.07.29.04.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:38:52 -0700 (PDT)
Message-ID: <f77aab11-0e1b-4962-9d53-0bb2fcd6486a@linaro.org>
Date: Wed, 29 Jul 2026 12:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] media: qcom: camss: use
 fwnode_graph_for_each_endpoint_scoped() to simplify code
To: Frank.Li@oss.nxp.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
 Guoniu Zhou <guoniu.zhou@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20260625-fw_scoped-v3-0-ffd0868e498d@nxp.com>
 <20260625-fw_scoped-v3-4-ffd0868e498d@nxp.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260625-fw_scoped-v3-4-ffd0868e498d@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2026 15:17, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use fwnode_graph_for_each_endpoint_scoped() to simplify code.
> 
> No functional changes.
> 
> Reviewed-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - fix typo simplify
> - collect andy, gouniou and loic's review tags
> ---
>   drivers/media/platform/qcom/camss/camss.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 2123f6388e3d7..23f3cc30a15a5 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4793,30 +4793,23 @@ static int camss_parse_endpoint_node(struct device *dev,
>   static int camss_parse_ports(struct camss *camss)
>   {
>   	struct device *dev = camss->dev;
> -	struct fwnode_handle *fwnode = dev_fwnode(dev), *ep;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>   	int ret;
>   
> -	fwnode_graph_for_each_endpoint(fwnode, ep) {
> +	fwnode_graph_for_each_endpoint_scoped(fwnode, ep) {
>   		struct camss_async_subdev *csd;
>   
>   		csd = v4l2_async_nf_add_fwnode_remote(&camss->notifier, ep,
>   						      typeof(*csd));
> -		if (IS_ERR(csd)) {
> -			ret = PTR_ERR(csd);
> -			goto err_cleanup;
> -		}
> +		if (IS_ERR(csd))
> +			return PTR_ERR(csd);
>   
>   		ret = camss_parse_endpoint_node(dev, ep, csd);
>   		if (ret < 0)
> -			goto err_cleanup;
> +			return ret;
>   	}
>   
>   	return 0;
> -
> -err_cleanup:
> -	fwnode_handle_put(ep);
> -
> -	return ret;
>   }
>   
>   /*
> 
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

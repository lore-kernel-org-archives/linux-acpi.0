From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2/6] Add display output class support
Date: Thu, 2 Nov 2006 20:51:17 +0000
Message-ID: <20061102205117.GA4887@ucw.cz>
References: <200611042113.56913.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752364AbWKBVWp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200611042113.56913.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Add display output class support
>=20
> signed-off-by =A0 Luming.yu@gmail.com

Hmm, strange characters inside signoff, and I guessthis should be Real
Name <my@ddress>.


> @@ -0,0 +1,129 @@
> +/*
> + *  output.c - Display output swither driver

Switcher?

> +static ssize_t video_output_store_state(struct class_device *dev,
> +	const char *buf,size_t count)
> +{
> +	char *endp;
> +	struct output_device *od =3D to_output_device(dev);
> +	int request_state =3D simple_strtoul(buf,&endp,0);
> +	size_t size =3D endp - buf;
> +
> +        if (*endp && isspace(*endp))
> +                size++;
> +        if (size !=3D count)
> +                return -EINVAL;

spaces vs. tabs...

> --- /dev/null
> +++ b/include/linux/output.h

I'm not sure if linux/output.h is not little too generic...

							Pavel
--=20
Thanks for all the (sleeping) penguins.

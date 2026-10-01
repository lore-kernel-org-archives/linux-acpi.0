Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD744E055
	for <linux-acpi@vger.kernel.org>; Thu,  1 Oct 2026 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852032; cv=pass; b=C8X+jeSBbiPM1fOimBlHY5ePSlEJkqKCSRXxudxQAOxz8BiAGe7vjokWlXh5/aNn0YWJcn/nxbpnuqznmYc2M8Zfc/3M90X8sCqanaulerubSbsBwWqQqs90HTBQACMZCi7ULRgJBNRW0xZikUIdX4MB1aQ190+oZW+tAP3uA7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852032; c=relaxed/simple;
	bh=Fs1edfuHx1in4X4WdK3upBMt8kh7e3INqc862LZOi+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIcptElLpMaimJsswJqWUTtF1EdwAoRNS9JgB233HUSeRPJDBbY/5RPkiUUR6pY1QkBFdv0O92+0vrBpP2m6ihITNndviafhGscx3E6SBgVNOYKSQIWiR1ZnQgntGJN/zIfIMyxGDZd2nbw/THAUutRCrvRAOkvw607Nmj/8e+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FAbj7CJM; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAbj7CJM"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso6306843d50.3
        for <linux-acpi@vger.kernel.org>; Thu, 01 Oct 2026 03:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790852028; cv=none;
        d=google.com; s=arc-20260327;
        b=U2/7XNiqW7fOvG4uiddkxok/1sbVRn/fZaafjBMXypr/Sta8wBJT1aHx9W30IquE8J
         gar0664p2bXlxC7b36JTxe4xYMHLX24SSfVW2DH5vUwEKqwyVz5HwrTfqoZ5Ec9cBWri
         ZucoHPPVhtHzO15JGUbE4bE1vAPQ9hc13NMvdnpGg1roeKQbC7aPHHONGvg3szujjgQx
         C72fEsqEnH9X9hdL0VimuTsc5KYr3hhQseC7dn/1VFvwczTqH32l3U11bvp9pqB/EPoU
         9c5+o35PBq8+PX4oVTQi3zsWdEyYyjnDJ5gMDPyHHdAP+k6HWVFCQ2hN6J3EC+JDotUk
         VgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        fh=CHVrE18mw5DtOXSsQ0H0oi1HCAmPNM9kmB4q76wZxzw=;
        b=sad5D7d38rfBnfzPtLVmwJ94FTQBX7QZHELhssD0Dt8A9p93t/O99bngypaBLpglYG
         Peh2XJiZswYboG27H07DQgdMvjFtZDOw3GB56zeNzKFOOL9jeq96hsMCE+hUZoNo20Zm
         Z9MBvtSloUHCSwLLVXoRdNuxap+4D50HG4OY8eLFv/hTjmRrH9TKvKvV9onaydPOue4R
         ndQaPkCGUIPkwMkP1JiEvEx8fbD4hD+hDXo9H516mxyniFM0wk5O3T8JHuNbWN31raBq
         UYThC6gdYDP6SIiEc43Kp8zpq3vU39LGviNx2Aw8ZoU/nSLIlH68b8gDu3iB6XdsNLG6
         sDng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790852028; x=1791456828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        b=FAbj7CJMgab72MHHmfF2iW2O3xqNR2anisVVFAtjFiL8Qh2Pe5qy3EyOrrPogoYZG0
         bHFeHvcH710U1lLtLuR3jI9u641NZFI/ayhqFd8MJYamxB6t0hvhIGtP6038fE2n9VNh
         aGUR74pT+Qqo5mbpidnVPdUTQ8clM7IBi2Ymc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852028; x=1791456828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEbjjiBAb1Gv1/q3JktK2vYVX0s4JpnfBYopaxaaLpw=;
        b=i0V15XkBev5qgf192+QJWcJoSJ2aNHSiw0VZDVUk2mWJ8bJLcN9kFxXYkooIbXWVMp
         1uifJ2bojnE03SbjbTXY6DRBF6u2MR33NICQGIiQ78bOtMvJBP0g158XLQcEdlr3BJn9
         48J8nito32d3YUHFhCiWMUuJkCbOuql+IbcsOAM2BGD5TqEFxBmZLNkubZwPNHJruYcz
         Zw/YpvSmuZsIZIdd1tplFVW6VkhLtKLIH8EtpXyfPmS6M24OKakrcbVBLmT85tT5r1Am
         KOO/9/orVHYPoqO5nKTYLbnqBgQMPZYnEJpdlNtHlENS0vvGY2C7mM9hOyW2weL0DdRu
         HMIA==
X-Gm-Message-State: AFq9FYJec/fSkvOUaoTE3LedAtUsdU0PIeakumdDev3Gmj9Hp7Gr65Wz
	1NPiRGZCA8b0SIkQK6prKw4SjsuwqLJx8rSPqS/GNvi8rrRlBzevNFqEEM6ou+Fm8e044ZrDTYB
	oHRdDyW2GJgBLf6jRjNk+XUZJzddZGdL6HeZMATfz
X-Gm-Gg: AYBFou11kacRVNPz/BTtNXKxhgnCD861lqD6Hp8XJIKEu6Ofpmfq5jWx3ern17Qrh4i
	sxlzFcXgcM5TOSeMPPr8VqOitC8bi17TBwiSrJ8a0YKzEzTce0KON1IKM/5UOYQjpx86ZzzR9FY
	NqemYor8E9BejgmunRpwA8qUGo4z0ex86K6OUY+guik+Nb61eEOpmYP02nix/Cx0NHBZvz9JO85
	0nbElFot49mdylQpDLLCyWgHh4IokQzy55IMW2yIvYUfdykVnQj4P5N6sJ/kiTvA3U/je/g3RP8
	TABqflNw9iB4qJxdK1UhqQwOqPknRoZeWnOSL4Q9pnw9qTuJQ1kY8ilJA8qe3xUES09lhDJKweg
	5H4YmqITI2Q==
X-Received: by 2002:a05:690e:4105:b0:676:9954:81ef with SMTP id
 956f58d0204a3-676995489a9mr323421d50.14.1790852028003; Thu, 01 Oct 2026
 03:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916075745.3549953-1-wenst@chromium.org> <20260916075745.3549953-7-wenst@chromium.org>
In-Reply-To: <20260916075745.3549953-7-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 1 Oct 2026 18:53:36 +0800
X-Gm-Features: AclHuK_wafiRDk696txMZ3q8q7Qaz4NsP-wYkipLMPcHq1r5tW6zotnKrD-_NRc
Message-ID: <CAGXv+5GdBUafk6niG-UMDx=z6LJQ6iHAWhDpm1Ly2ce6CQDaxg@mail.gmail.com>
Subject: Re: [PATCH v9 06/15] usb: hub: Associate port@ fwnode with USB port device
To: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 3:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> When a USB hub port is connected to a connector in a firmware node
> graph, the port itself has a node in the graph.
>
> Associate the port's firmware node with the USB port's device,
> usb_port::dev. This is used in later changes for the M.2 slot power
> sequencing provider to match against the requesting port.
>
> To avoid potential conflicts with ACPI firmware nodes and then causing
> power management issues, only assign the firmware node if the hub's
> firmware node is not an ACPI firmware node.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v5:
> - Added extra |struct fwnode_handle *| local variables to shorten lines
>   (Andy)
> - Added comment about passing fwnode_graph_get_port_by_id() return value
>   directly to device_set_node() (Andy)
>
> Changes since v4:
> - Dropped unused |hdev| variable
> - Added flags for fwnode_graph_get_port_by_id() with
>   FWNODE_GRAPH_DEVICE_DISABLED so that even incomplete
>   ports can be connected
>
> Changes since v3:
> - Added missing fwnode_handle_put()
>
> Changes since v2:
> - Skip assignment if hub firmware node is ACPI node
> ---
>  drivers/usb/core/port.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index b4452b665f59..c0a51d9b06a6 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -7,6 +7,7 @@
>   * Author: Lan Tianyu <tianyu.lan@intel.com>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
> @@ -358,6 +359,11 @@ static void usb_port_device_release(struct device *d=
ev)
>  {
>         struct usb_port *port_dev =3D to_usb_port(dev);
>
> +       /*
> +        * At this point ACPI nodes and swnodes have been removed by
> +        * device_platform_notify_remove() in device_del().
> +        */
> +       fwnode_handle_put(dev_fwnode(dev));
>         kfree(port_dev->req);
>         kfree(port_dev);
>  }
> @@ -754,6 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, i=
nt port1)
>  {
>         struct usb_port *port_dev;
>         struct usb_device *hdev =3D hub->hdev;
> +       struct fwnode_handle *fwnode =3D dev_fwnode(&hdev->dev);
>         int retval;
>
>         port_dev =3D kzalloc_obj(*port_dev);
> @@ -782,6 +789,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, =
int port1)
>         port_dev->dev.driver =3D &usb_port_driver;
>         dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->de=
v),
>                         port1);
> +
> +       /*
> +        * ACPI FW nodes are associated later when device_register() happ=
ens.
> +        * Skip assigning one here to avoid potential conflicts.
> +        */
> +       if (!is_acpi_node(fwnode)) {
> +               struct fwnode_handle *port;
> +
> +               /*
> +                * fwnode_graph_get_port_by_id() returns either a valid f=
wnode handle
> +                * or NULL. Passing NULL to device_set_node() clears any =
associated
> +                * fwnode. It is effectively a no-op here, since no fwnod=
e has been
> +                * assigned to the newly created device yet.
> +                */
> +               port =3D fwnode_graph_get_port_by_id(fwnode, port1, FWNOD=
E_GRAPH_DEVICE_DISABLED);

After AI hinted, I found some dwc3 hardware to test this on.

"port1" needs to be remapped using usb_hcd_find_raw_port_number() when the
hub is the root hub. Otherwise both HS and SS ports end up getting the
same port node, which is incorrect.

Same needs to be done for "usb_of_get_connect_type(hdev, port1)" some
lines above the diff context.

This mapping is currently only done in usb_acpi_get_companion_for_port()
and usb_alloc_dev().


> +               device_set_node(&port_dev->dev, port);
> +       }
> +
>         mutex_init(&port_dev->status_lock);
>         retval =3D device_register(&port_dev->dev);
>         if (retval) {
> --
> 2.55.0.1032.g73a4cd73de-goog
>

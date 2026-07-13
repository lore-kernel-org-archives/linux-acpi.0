Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25E382397
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924871; cv=pass; b=lFPL+P29VPNcxN4R5GXBRts5w82ILeK1qiRw+kI70tv7kbW5xFilUznstg++0V+ZehD8cZH6tEYYgFrsQDjtVjeX6SJUfe4kp7gpK9YZ9eVjyLf2s/gqodX7GbzpO1/SLloChm2c6t5GaYu4JUNGDbZaGgKwIbVCAXYpkYNarSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924871; c=relaxed/simple;
	bh=SoNHDrWROasgfui4FF2PQ43gjyBa3I1JHB7dBso0fYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b82g2zLOrX2Q5D+bAPWQ6UWohZCKNkfrwXO6mJHLvkAPstPyMuF6uYzSSObbdzm1eTo8htTCVIQNNALu7Ina58R7JfyoEbEFceWSK/5DQzmxPyrz3lC/YEvoLkpZV3Z60vUUkIxvrxwspWiYdTknxqpNwag6b7nqNnFLCdbhLxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dp5fV1eQ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dp5fV1eQ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-667f07e2ae0so38617d50.3
        for <linux-acpi@vger.kernel.org>; Sun, 12 Jul 2026 23:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783924868; cv=none;
        d=google.com; s=arc-20260327;
        b=YdrrzAdBenwYARj2q+jEOrrk+yIoKciLQoNAuOf6S/iVLaAyNe0iLxKlU5oVszEIda
         J0sIwJetqGPMyn6XTaH7gMuDuD6npbFD9dlkq0sM2WWulkyV0MbT2jU/vFj0/MLJ/a1a
         LLNk9FOa4zcelGatSC0mkX/IRkORkFEGRoddWzCU07wtjLgKc07KejS8GGR5YgSU7+Z/
         Fgy+JY9Fbd0xqWrzh4/GKj6/5H+J47UcLxwzh4ryVXkSs9wpCXIiPwoILd1FexM4IKfw
         FW5Dsshj/o9sALREFfdevc3cjH5se79sIF7d0qqg6DTtKRYAvQqrCklbBTV082HCyxhN
         GMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ALHFFl4QIG5q5cwsXiSsf9xTcJ7Y7YxsHiqneCAHa/Y=;
        fh=3HVJ+6VeBbhCqPw6ZhGJryxTtWwlgW/iXTpEMkhFkxI=;
        b=NZB99dddfMoJrsKKafWcj9An/iMwvwTUf7IGXTPC1s/g8CU8SPGe9nfqtEH59m3kBx
         /BMZvQRFTqk4ewiOgq7bvMtoyNA8rzwAQz6JnUdTpsrE1A/5ba5uXOnKJgpRO0DRN7w/
         6uItZn/+YjoL29nKe9q/yzbHj3FNmZ4nLvho3EBGkvE6Sa/zH09x6P4GkvWS/D+A0Ilc
         NuaIhBIzaVeWpT8BKkFrQN/5zhzc1s4IOSBX9O8+FCwAQGVgEKCdFUPBsw7PFLCKsNBc
         nfsVFMG1emLNqYLnCkEHeBVZVIu+MZQGE5RmOi219VtIPUFnBa9a2Gt9w1hS6wn3JGHA
         y7Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783924868; x=1784529668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ALHFFl4QIG5q5cwsXiSsf9xTcJ7Y7YxsHiqneCAHa/Y=;
        b=dp5fV1eQzI+Q9ABLpMoytSwVqvJkNnm2q+8k2+hUF9hHSoTetIdx8MaKR92N+gi9S7
         Kx7MDUrv2AEYWY1uVHPwlc3LFMd1lwKnjDoiReY9JfjSvl2GMjvxVMFaEZr0v14r1lfw
         b1XdoUkbRVAIP9uqCn18sKtv4fqDOJRWOinkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924868; x=1784529668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALHFFl4QIG5q5cwsXiSsf9xTcJ7Y7YxsHiqneCAHa/Y=;
        b=V+yAC9h9mIEDiRCc38sbezzACMFIh6CKPkJFjSkgUPHF/OYyZ90TfwILmPZfbd51Bj
         DuWk7lFTOQ93wxlkPXIiMl/PWSiVRH5u239H48FFpZklFTppmMjkCRAgWPzOW/6B2xnU
         a9QT65TRHF5Lx6C6KOnH/nbzGtfZwut5G4/BrcJJPgFWLn+yPNE6qNgiXxWF15Hu4Nm/
         yPntZXE1e2ZsQ9MxUXzA+2Ts0E2OoCEojSd+Tt9UNXiSFTyy5bfXo4b4gplUJ6wvFP4Y
         rGshsKI5OTHlrNdGVHrqSWmL7xdiXmLAsJwXDFkYg2tmyrVaf7si/uafXFjB1PU80B9G
         aHDA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3mULcjsi2MvipL5DfQYi89ANu9BB30nB6yuo0j5kWrzy4ylXH0MNk6mUKaeFd0iuM/ErKxC3tXLrD@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvHsr85mSY05NWngkqbO/iHQj39Xz+slu1rfhCTlcRy477LcN
	OaTVPU8TKNrVW9u63HL7W5gcl02hj5DEgLLoySm5IH7WTDioKWqaGH3rWyunBHQ/e8cqH5g2gsO
	Ww461MJqy0hbINSm9/ms2Qr3ljyPNSWZcvaUUIjJ9
X-Gm-Gg: AfdE7cmSkVKGTFA6X09xTsv3jqgdBiAjD445C2bs0a88gnkEHHLQYCKPmR+scwqRUdx
	KjXBkyZkxqnljnyB64vlaqJWZz/ndTMJuCQMaQqiERh5FckqXHsuSrCO1c22VYUeeDxipqVK6se
	I24T0m5P8nFzl7f5YNkvnrzOCTMmUUme1KGbngUqpnKiVOkFa+jvqRxoZy8hUB8dsFW3GIh58pK
	q+NAch9B9UN+Rxvf8u/sQ1ManqOfQ/ECvRvRJVZOfrpGmrMWb68pVDuETvIqaWRp0Vh9L46f+YK
	o0NkUCB4DzLcdhyH+LTFMz/f+GeN/+ZmmtIt
X-Received: by 2002:a05:690e:138f:b0:667:db66:eb59 with SMTP id
 956f58d0204a3-667db66f471mr5286970d50.22.1783924867897; Sun, 12 Jul 2026
 23:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095726.704448-1-wenst@chromium.org> <20260709095726.704448-6-wenst@chromium.org>
 <2026071025-diffused-jersey-0d94@gregkh>
In-Reply-To: <2026071025-diffused-jersey-0d94@gregkh>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 13 Jul 2026 14:40:56 +0800
X-Gm-Features: AVVi8CffSvw8dKrdOHbSnASMEsx0puSGrR918doi02cLaaF9gK20T18TFDW9zpc
Message-ID: <CAGXv+5EyJ3WewkWfEy=XNA=VoU4Fuhi2K6evkvFanWhVe8J=ag@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] usb: hub: Associate port@ fwnode with USB port device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 8:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 09, 2026 at 05:57:10PM +0800, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v3:
> > - Added missing fwnode_handle_put()
> >
> > Changes since v2:
> > - Skip assignment if hub firmware node is ACPI node
> > ---
> >  drivers/usb/core/port.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > index b1364f0c384c..e8fb2acd77be 100644
> > --- a/drivers/usb/core/port.c
> > +++ b/drivers/usb/core/port.c
> > @@ -7,6 +7,7 @@
> >   * Author: Lan Tianyu <tianyu.lan@intel.com>
> >   */
> >
> > +#include <linux/acpi.h>
> >  #include <linux/kstrtox.h>
> >  #include <linux/slab.h>
> >  #include <linux/string_choices.h>
> > @@ -358,6 +359,11 @@ static void usb_port_device_release(struct device =
*dev)
> >  {
> >       struct usb_port *port_dev =3D to_usb_port(dev);
> >
> > +     /*
> > +      * At this point ACPI nodes and swnodes have been removed by
> > +      * device_platform_notify_remove() in device_del().
> > +      */
> > +     fwnode_handle_put(dev_fwnode(dev));
> >       kfree(port_dev->req);
> >       kfree(port_dev);
> >  }
> > @@ -780,6 +786,13 @@ int usb_hub_create_port_device(struct usb_hub *hub=
, int port1)
> >       port_dev->dev.driver =3D &usb_port_driver;
> >       dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->de=
v),
> >                       port1);
> > +     /*
> > +      * ACPI FW nodes are associated later when device_register() happ=
ens.
> > +      * Skip assigning one here to avoid potential conflicts.
> > +      */
> > +     if (!is_acpi_node(dev_fwnode(&hdev->dev)))
> > +             device_set_node(&port_dev->dev,
> > +                             fwnode_graph_get_port_by_id(dev_fwnode(&h=
dev->dev), port1));
> >       mutex_init(&port_dev->status_lock);
> >       retval =3D device_register(&port_dev->dev);
> >       if (retval) {
> > @@ -852,6 +865,7 @@ int usb_hub_create_port_device(struct usb_hub *hub,=
 int port1)
> >
> >  void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
> >  {
> > +     struct usb_device *hdev =3D hub->hdev;
> >       struct usb_port *port_dev =3D hub->ports[port1 - 1];
> >       struct usb_port *peer;
>
> Is this last variable addition not needed here?  It's not used.

Indeed it is not used. It was left over from me figuring out how to release
the fwnode handle. Will drop it in the next version.

I still have some other comments to cover. And I want to go through the
code one more time to check Sashiko's concerns on the main patch
"usb: hub: Power on connected M.2 E-key connectors with power sequencing AP=
I".


ChenYu

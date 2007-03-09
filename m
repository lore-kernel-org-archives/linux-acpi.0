From: Stelian Pop <stelian@popies.net>
Subject: Re: [RFC] sonypi acpi implementation and the future
Date: Fri, 09 Mar 2007 17:10:02 +0100
Message-ID: <1173456602.12833.46.camel@localhost.localdomain>
References: <20070308141316.GA4229@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:2819 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767334AbXCIQKG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 11:10:06 -0500
In-Reply-To: <20070308141316.GA4229@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Le jeudi 08 mars 2007 =E0 15:13 +0100, Mattia Dongili a =E9crit :

> What's already there:
> - enable the device using acpi tables information and methods
> - input layer event reporting
> - acpi event reporting
> my current code is here: http://www.linux.it/~malattia/sony-pic/

Ok, I guess you solved the missing interrupt problems then.

> What's still missing:
> 1- bluetooth power control
> 2- fan speed control
> 3- brightness control
> 4- battery status/capabilities reading
> 5- ac status control
> 6- temperature reading
> 7- motion eye camera support
> 8- /dev/sonypi and its IOCTLs for the above points (1-7)
>=20
> Future:
> I've not dropped the idea of merging sony-laptop and sonypi, I'm
> currently implementing it as a separate driver for easier testing
> only.
> So the great sony-laptop would deal with both the SNY5001 (SNC) and
> SNY6001 (SPIC) acpi_devices, having a parameter to disable the latter
> and anyway if the older/obsoleted sonypi grabs the SNY6001 device fir=
st
> sony-laptop couldn't get it anyway.

Makes sense.

> 1 and 2: it makes sense to implement them as platform_device
> attributes[1] together with already existing sony-laptop's attributes
> once I merge the drivers.

Ok.

> 3: is in sony-laptop already (does it work also with very old laptops=
?
> as said I have a gr7k that dates back in 2000/2001, is a Type2 and
> works. I can't tell for Type1s which are even older). Stelian, out of
> curiosity is the C1 the only Type1 or are there more?

No, there were other Type1 models, and from what I remember the SNC was
present in all older laptops.

> 4, 5 and 6: are available through ACPI, those EC hacks were mainly fo=
r
> ACPI-enabled-but-using-APM older laptops.

Right.

> 7: could be added as is and actually modifying it would break the mey=
e
> driver (is it really still maintained?) but sonypi and sony-laptop
> can't export the same symbol.

The meye driver only supports a very old Vaio picturebook camera
(C1VE/C1VN series). I don't have the hardware any longer, and there
aren't probably a lot of users for this driver.

Stelian.

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

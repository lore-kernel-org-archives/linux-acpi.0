Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773303CF960;
	Wed, 17 Jun 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781738111; cv=none; b=IwGn5NsDfG46THto207phovUJASsggTS7H3/t4sXy+1MV2MZnmFAgN73aZHhoqUhY9ch+TLa2ScpgOsTKOCp5GytrK66k+J59Cb/GqAKeBo4v/6uwtquy1JJbtRKj9IAQ9sqLZiU5AAcgZICeIQfKmZ0MV4tcGEnfz+0ieK0ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781738111; c=relaxed/simple;
	bh=o+F0liLTXSFLI03+WTFIeQgJd2drifTsb4A00QETRFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ33uoGbN930formVvv1DmoPRD6UyEDfnUk5rDNpLiWgxVcDG/4GPPs85F1YwhLnLAs3qJSwAksECKUDRBpAUjF8Yv9ovYPegEREbHDa92pFGXX6HVgDkGOfQdqw/nRnU4jKNV+kCOl476dztStYuIicbMYb2voRQjg0eaDIJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ejABlu89; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ejABlu89"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5D9B3276D1;
	Thu, 18 Jun 2026 01:15:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ3TJKn5_kJG; Thu, 18 Jun 2026 01:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781738105; bh=o+F0liLTXSFLI03+WTFIeQgJd2drifTsb4A00QETRFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejABlu89T8XCbyt2qUjEwf94Y5pEWqXDtMbJMCNdhCfzQwv1voSZyrrMq6Ti9sY9z
	 KH01dObjEaozhKnqnBgq7XRHaJgrbhV1t+4a9/dKT0FS9F2x/Zw5M8jCYuR0gyqbVJ
	 IfnWo5fx/7ef1/8dHnu776hmOBw/ThxGJ1kpot3/X6hQj0u+Ct1oFjgsWHkyn5/oG2
	 K4ebjJSa23/koMOf6yV9zWeMDsxx3ViMA7ltXOBEUQ7pVlbFE4TfsaYK0Pd8Cm6/nK
	 RD9cBocKijfnB/cGCfSzAbPAX5zwLOjUBtv3HEEcV13ZTDzQP4QwW0vkYq44SLB1Xg
	 8Jklqm+lWOjlw==
From: Marco Scardovi <scardracs@disroot.org>
To: w_armin@gmx.de
Cc: andriy.shevchenko@linux.intel.com,
	bnatikar@amd.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	scardracs@disroot.org,
	westeri@kernel.org
Subject: Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series
Date: Thu, 18 Jun 2026 01:14:24 +0200
Message-ID: <20260617231428.96076-1-scardracs@disroot.org>
In-Reply-To: <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
References: <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Armin,

On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:
>
> could you share the output of "acpidump" on your device? I suspect that Asus
> uses a _DSM control method to tell Windows to invert the polarity inside the
> ActiveBoth check.
>
I have extracted and decompiled the ACPI tables (DSDT and SSDTs) from acpidump.
You can find the raw acpidump.out and the decompiled ASL tables in the
following Google Drive folder:
https://drive.google.com/drive/folders/1aTqLAnUhrTsPdpA8tfOFyRopG3P3DGnc?usp=drive_link

As far as I can see/understand there is no _DSM method defined under the
GPIO controller device (AMDI0030) or the \_SB.GPIO scope.

Under the _AEI method (defined in SSDT9 line 188-193), pin 21 (0x15) and
pin 24 (0x18) are defined as:

GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
    "\\_SB.GPIO", 0x00, ResourceConsumer, ,
    )
    {
        0x0015 // Pin 21 (Touchpad attention line)
    }

When triggered, they evaluate the _EVT method which calls:
Case (0x15)
{
    \_SB.PCI0.SBRG.HNC0 (0x15, Zero)
}

Since Arg1 is Zero, HNC0 executes the Else branch, invoking M009 and ATKM/ADTM,
which stalls synchronously for ~36 seconds when executed during the probe path at 
boot time.

Thanks,
Marco

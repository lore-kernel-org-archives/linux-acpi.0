From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH/RFC] drm/radeon: ACPI: veto the keypress on ATIF events
Date: Wed, 1 Aug 2012 10:02:13 -0400
Message-ID: <CADnq5_M5AvcrRZZBE1Xsx2XD_3ok0hkehYS_H2c6Sc1pUjirrg@mail.gmail.com>
References: <20120728145626.GA6304@growl>
	<CADnq5_OjWoLS=GO_qYEBeTPvXrKJeJUjUCzOZS5w3erjHeFDqg@mail.gmail.com>
	<20120729130644.GA12378@growl>
	<CADnq5_OdKXsiVnFbkBNB2ue4df6tGaZ7bVMP+TvetFcy0faKog@mail.gmail.com>
	<20120730202449.GA5600@growl>
	<CADnq5_NP9Rw8DhmS+Q5G1PaUqcHQtVA6KoCGH5MME6DEd-Lw7Q@mail.gmail.com>
	<CAKPcRGpL6JBx5MnWk6fFVOYCPQGeeDC-ytOwA+J+gEEZS+4SuA@mail.gmail.com>
	<CADnq5_NN8OcmyKDemO=Mv0as-02sYEHxxbn2G4XtSmpzEsnR0w@mail.gmail.com>
	<20120731200520.GA5425@growl>
	<CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
	<20120801134900.GA7909@growl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64732 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab2HAOCO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2012 10:02:14 -0400
Received: by wibhr14 with SMTP id hr14so4022481wib.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Aug 2012 07:02:13 -0700 (PDT)
In-Reply-To: <20120801134900.GA7909@growl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Aug 1, 2012 at 9:49 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> AMD ACPI interface may overload the standard event
> ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In such
> cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) to the
> userspace because the user did not press the mode switch key (the
> spurious keypress confuses the DE which usually changes the
> display configuration and messes up a dual-screen setup).
> This patch gives the radeon driver the chance to examine the event and
> block the keypress if the event is an "AMD event".
>
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

Looks good to me, but I'm certainly not an ACPI expert.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

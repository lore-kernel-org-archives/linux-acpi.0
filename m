From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: sony-laptop: fix early NULL pointer dereference
Date: Mon, 4 Apr 2011 21:26:00 -0300
Message-ID: <BANLkTinYJHxO4KL6xEzQB1Q-YAdggNL9Wg@mail.gmail.com>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
	<20110401172241.GA26851@srcf.ucam.org>
	<BANLkTikPjwowBge82viT+Ma5UnP0fA-pew@mail.gmail.com>
	<20110402100043.GA5890@kamineko.org>
	<BANLkTikVGWM3T1y2XvwkHB+Yub5EhG1RPA@mail.gmail.com>
	<20110402155549.GA6724@kamineko.org>
	<BANLkTimJa3CSWouTMJD5V0ZuMa67YXy88Q@mail.gmail.com>
	<20110404234448.GA24957@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37951 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab1DEA0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 20:26:01 -0400
In-Reply-To: <20110404234448.GA24957@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrea Gelmini <andrea.gelmini@gmail.com>, anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>

On Mon, Apr 4, 2011 at 8:44 PM, Mattia Dongili <malattia@linux.it> wrot=
e:
> Author: Mattia Dongili <malattia@linux.it>
> Date: =C2=A0 Fri Apr 1 10:01:41 2011 +0900
>
I think most of the patches doesn't include these above lines nor the
subject line in the description. Also when submitting a patch to the
list, please don't forget to put [PATCH] on the subject line.

git format-patch should output the right format.

> =C2=A0 =C2=A0sony-laptop: fix early NULL pointer dereference
>
> =C2=A0 =C2=A0The SNC acpi driver could get early notifications before=
 it fully
> =C2=A0 =C2=A0initializes and that could lead to dereferencing the son=
y_nc_handles
> =C2=A0 =C2=A0structure pointer that is still NULL at that stage.
> =C2=A0 =C2=A0Make sure we return early from the handle lookup functio=
n in these
> =C2=A0 =C2=A0cases.
>
> =C2=A0 =C2=A0Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>
> Hi Matthew,
> if it's not too late, can you pick this one up instead of the previou=
s
> one (89ec2feafaedd759e53346d641f60863a14cfb9e)?
> If it's too late I'll try and do a round of return value fixes later.
>
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x8=
6/sony-laptop.c
> index b2ce172..de79c18 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -810,6 +810,11 @@ static int sony_nc_handles_cleanup(struct platfo=
rm_device *pd)
> =C2=A0static int sony_find_snc_handle(int handle)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* not initialized yet, return early */
This comment is useless, it is just repeating what the codes does ;) I
think you can just remove it.

> + =C2=A0 =C2=A0 =C2=A0 if (!handles)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 0x10; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (handles->c=
ap[i] =3D=3D handle) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dprintk("found handle 0x%.4x (offset: 0x%.2x)\n",
> --
> mattia
> :wq!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

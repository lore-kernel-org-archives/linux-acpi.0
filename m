From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Mon, 30 Jul 2012 17:28:19 +0800
Message-ID: <1343640499.6341.80.camel@linux-s257.site>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	 <1631921.mapqS8Vd5c@pali> <1332303391.10557.391.camel@linux-s257.site>
	 <7304456.Po7HTnWu9F@pali>
	 <CAEPe-GKnpbzpka7y=ufukt9EUwWu95my51dGV1K41PBrmjPcRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56472 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab2G3JbG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2012 05:31:06 -0400
In-Reply-To: <CAEPe-GKnpbzpka7y=ufukt9EUwWu95my51dGV1K41PBrmjPcRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>, pali.rohar@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2012-07-30 =E6=96=BC 10:17 +0200=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> On Sat, Jul 28, 2012 at 4:47 PM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > Hello, I have some good news. Radeon patches from this post
> > http://lists.freedesktop.org/archives/dri-devel/2012-July/025535.ht=
ml
> > export brightness file /sys/class/backlight/radeon_bl/brightness
> > And finally with these patches I'm able to change brightness on my =
EliteBook.
>=20
> Wow, it's great news :) I was reading yesterday info about ACPI
> patches from AMD on Phronix and thinking will it help or no, and now =
I
> have an answer :)
>=20
> Regards
> Artur

Yes, thanks for Alex's 3 patches, those patches also works to me on my
machine for backlight control.


Thanks
Joey LEe

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

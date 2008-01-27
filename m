From: Stephane Ascoet <stephaneascoet@free.fr>
Subject: Re: Troubles waking up from suspend (S3) - how to debug?
Date: Sun, 27 Jan 2008 21:19:19 +0100
Message-ID: <479CE747.8080606@free.fr>
References: <200801271842.38007.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759032AbYA0SQX@vger.kernel.org>
In-Reply-To: <200801271842.38007.bonbons@linux-vserver.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Bruno Pr=E9mont a =E9crit :
> I'm currently trying out suspend (S3) on a few machines but none of t=
hem wakes=20
> up completely/properly (I have a few more hosts I'm planning to try s=
uspend=20
> on once I can get useful information out of those not waking up prope=
rly).
>=20
> Tested kernels: 2.6.24(-rc8), on one 2.6.23.8
>=20
> To suspend I enter the following from console:
>   echo -n mem > /sys/power/state



Bonjour, it seems for me that using echo isn't the right way. You could=
=20
follow instructions at the end of:=20
<http://community.ofset.org/index.php/Freeduc-cd17_how_to>

--=20
Bien cordialement, Stephane Ascoet, conseils pour que la technologie=20
soit un progres respectueux de la vie.
Album photo:<http://www.flickr.com/photos/stephaneascoet/>,=20
site:<http://community.ofset.org/wiki/User:Sascoet>

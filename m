From: Ivan Gyurdiev <ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org>
Subject: Re: 2.5.75 - ACPI and sound lockups
Date: Sun, 13 Jul 2003 13:09:16 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307131309.16078.ivg2@cornell.edu>
References: <Pine.LNX.4.33.0307131238520.561-100000@frog.athome>
Reply-To: ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0307131238520.561-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 July 2003 06:43, you wrote:
> Salut Ivan,
> my first look says, that IRQ 3,7,10 and 11 (which is the one, that bit
> you, I think) has to be level and not edge.
> As irq 11 is shared, this is no good!
>
> May you please get the information you provided for 2.5.74 for the
> 2.4-kernel you mentioned, too (including ACPI-version from
> /proc/acpi/info)?

I no longer use a 2.4 kernel. I've forgotten which one worked last.
I tested 2.4-current and unfortunately it doesn't work either.
I could test older kernels, I guess - will that be helpful?
Which kernel should I test?

btw: irqs 3,7,10,11 are edge and not level in the nonworking 2.4 kernel

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Version of acpi in the current 2.5.75 kernel is:=20
version:                 20030619
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom offlist message I forgot to cc:

ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 2=
55
ACPI: No IRQ known for interrupt pin C of device 0000:00:11.5

for DEVICE in 10.0 10.1 10.2 10.3 11.1 11.5 ; do
echo "`cat /sys/devices/pci*/*$DEVICE/name`"
done

VIA Technologies, In USB
VIA Technologies, In USB (#2)
VIA Technologies, In USB (#3)
VIA Technologies, In USB 2.0
VIA Technologies, In VT82C586/B/686A/B PI
VIA Technologies, In VT8233 AC97 Audio Co

usb hubs...connected to irqs 3, 7, 10, and 11 on an ACPI enabled 2.5 kernel.
and 11 is shared with the soundcard.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1

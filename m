From: Thomas White <taw27-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: DPMS with ACPI
Date: Sat, 7 Dec 2002 16:57:27 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021207165727.17f6222a.taw27@cam.ac.uk>
References: <20021207171140.363b2276.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021207171140.363b2276.gigerstyle-OI3hZJvNYWs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 7 Dec 2002 17:11:40 +0100
Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org> wrote:

> I've seen that DPMS needs an APM conform BIOS. The call is made trough
> /dev/apm_bios. Is there an equivalent interface for ACPI? How can I
> use the DPMS feature with ACPI? This would be a nice feature for my
> Laptop.

Proabably not the most helpful of comments... but DPMS seems to work
fine for me with ACPI rather than APM running things - I definitely
don't have /dev/apm_bios, but "xset dpms force standby" works properly,
to put the screen to sleep.

( Sony Vaio FX601 with Linux 2.4.19 + ACPI-20020821 and XFree86 4.2.0 )

Tom

______________________
Thomas White
Downing College
Cambridge


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

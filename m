From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: latest acpi: new behavior of the UPBI method
Date: Thu, 19 Dec 2002 16:15:29 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0212191612540.10665-100000@dynast.gaugusch.at>
References: <3E01E193.3040406@eavr.u-strasbg.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E01E193.3040406-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Dec 19, Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org> wrote:
> On my VAIO FX702, I have a recurrent problem
> with the battery info:
>
> * the time needed to dump /proc/acpi/battery/BAT1/info
> is about 0.5s and during this time the box is frozen.
> * the last entries in info are corrupted, i.e. model number,
> serial number, battery type and OEM info.
Robert Moore from Intel is working on this issue (I help him by trying his
patches).

> As reported by another VAIO user on this list, my feeling is
> that these problems are linked.
No, they are not. The bad writte model number should be fixed in the next
version. Don't know about the large delay, but probably this isn't fixed
yet.

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/

From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Kernel with acpi hangs on compaq presario 1700
Date: Mon, 16 Dec 2002 10:00:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021216090024.GD10230@poup.poupinou.org>
References: <200212142221.15212.hogenberg11@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200212142221.15212.hogenberg11-RSh1/+X/PmFmR6Xm/wNWPw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaap Hogenberg <hogenberg11-RSh1/+X/PmFmR6Xm/wNWPw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 14, 2002 at 10:21:15PM +0100, Jaap Hogenberg wrote:
> Hi,
> 
> I'm new to this list so forgive me if this is a FAQ:
> 
> I'm tried kernel 2.4.20 with the acpi patches of 12052002 and 12122002
> as well as a 2.5.51 with and without patch (12132002) and when I include
> acpi support , the kernel will hang when probing the PCI bus.
> 
> I have seen references about acpi on compaq laptops indicating that it needed
> some tweaking (dumping acpi tables to a file) but as these were 
> very old postings to linux-kernel mailing list , and the answers there
> were quite inconclusive I thought I'd ask here.
> 
> Is there some (recent :-) ) documentation on getting acpi working
> on this laptop ? 
> Or is there anything else I should try in my kernel config ?
> 

Look at:
http://dude.noc.clara.net/~faye/compaq2701ea/
http://www.cpqlinux.com/acpi-howto.html

This 2 pages should give you a good understanding for the compaq in general,
and the first one for Presario 2701EA in perticular.

Please note also that Compaq have released new BIOS in the mean time
which should be more ACPI friendly, AFAIK.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

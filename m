From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 16:23:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021119152333.GH691@poup.poupinou.org>
References: <3DDA3E96.50906@rwth-aachen.de> <200211191540.58738.douard@magic.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200211191540.58738.douard-nJJpUPIbDOA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Douard <douard-nJJpUPIbDOA@public.gmane.org>
Cc: Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2002 at 03:40:58PM +0100, David Douard wrote:
> Hi,
> 
> not sure about it, but have you any debug info on in ACPI ? Maybe, try to put 
> debug info off (echo "0" > /proc/acpi/debug_level ), and see if that change 
> anything.
> I say that cause I used to have a lag due to debug info (which I must admit I 
> put to a quite hight level, producing many data).
> 
> For the question about polling, it should be possible, according to specs (if 
> I remember well, I'm not very sure) to have ACPI send an exception, thus 

It is called an 'event', but, well, the idea is here.

> catch it (with ospmd, acpid or whatever daemon you want) only when bat status 

Yes.  In fact, you shoud have something like that, when battery info change:

novae:~# cat /proc/acpi/event     
battery BAT1 00000080 00000001
battery BAT2 00000080 00000000


The /proc/acpi/event should be read actually by acpid or by ospmd, thus
those events would be forwarded to an another user space program (as a
battery status monitor).  It would be more easy to have that via
ospmd than with acpid.

In fact, ospmd abstract all this 'detail' for you, and you should
have the current state of the battery(ies), without worrying about
/proc files, by using libpower.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html

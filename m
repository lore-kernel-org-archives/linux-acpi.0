From: Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 17:00:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DDA6004.6030409@rwth-aachen.de>
References: <3DDA3E96.50906@rwth-aachen.de> <200211191540.58738.douard@magic.fr> <20021119152333.GH691@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DDA3E96.50906-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Ducrot Bruno wrote:

>On Tue, Nov 19, 2002 at 03:40:58PM +0100, David Douard wrote:
>  
>
>>catch it (with ospmd, acpid or whatever daemon you want) only when bat status 
>>    
>>
>
>Yes.  In fact, you shoud have something like that, when battery info change:
>
>novae:~# cat /proc/acpi/event     
>battery BAT1 00000080 00000001
>battery BAT2 00000080 00000000
>


OK, I will give it a try with ospmd and maybe the libpower included in 
the ospmd release.  Unluckily I have never seen any event in 
/proc/acpi/event on my laptop so I'm not sure if it's not working at all 
or if it's just misconfigured.

Again, any hint for documentation (for example on /proc/acpi/event or 
ospmd) would be helpful ;)

  Thomas




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html

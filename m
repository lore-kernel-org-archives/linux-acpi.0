From: "Arch. Giovanni Andrea Lucaferri" <lucaferri-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Solved] Re: power-off (Acer TM632)
Date: Tue, 20 Jul 2004 02:56:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40FC6DAA.6060809@makines.com>
References: <20040531213726.GA3298@zimen.sk> <20040719175904.GC2690@smeagol> <40FC32DA.9080302@makines.com> <20040719213747.GA26393@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040719213747.GA26393-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

mhh, no there isn't, but it's a good idea!


Keld Jørn Simonsen ha scritto:
> On Mon, Jul 19, 2004 at 10:45:14PM +0200, Arch. Giovanni Andrea Lucaferri wrote:
> 
>>Hi Emma, mizu, hgfelger,
>>it works! I've isolated the problem.
>>I only had CONFIG_RTC=Y in my kernel and that was the only problem.
>>I've set
>># CONFIG_RTC is not set
>>and everything works now.
> 
> 
> Is there a place where you can configure parameters for your machine
> model? Eg my laptop will need noapic to function. I can of cause set
> that parameter, but novices would not know this, and it would be better
> if the make and model be detected and the parameter always set.
> This is, I wonder if there is a repository for the make and models in
> the kernel.
> 
> best regards
> keld
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click

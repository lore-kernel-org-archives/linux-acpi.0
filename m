From: Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: Re: dsdt patch
Date: Wed, 04 Feb 2004 01:58:46 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401FB726.1080105@ihug.com.au>
References: <401CCB50.6010003@ihug.com.au> <20040202084457.GC8164@fuchi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040202084457.GC8164-5sK/Rx+du8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sebastian Henschel wrote:
> hello alimin..
> 
> * Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org> [2004-02-02 09:12 +0100]:
> 
>>Just want to ask where can I find a patch that will allow me to use my 
>>own dsdt for kernel 2.4.24? Is there such a patch flying around or is 
>>the kernel itself patched to allow implementation of custom dsdt table?
>>I am sorry if this is the wrong place to ask such a question but I could 
>>not find a mailing list for dsdt itself. I would very much appreciate if 
>>someone can point me to the right direction.
> 
> 
> you might try this:
> 
> http://gaugusch.at/kernel.shtml
> 
> also dino klein has announced a more generic patch last week or so,
> check the archives for that version.
> 
> hth,
>  sebastian

Thanks Sebastian. I feel a bit lost after consulting the more generic 
patch you suggested before. Yes, at the moment I have two choices, one 
is to use the initrd patch as you pointed out and the other one is to 
patch osl.c and compile the custom dsdt into the kernel. I just want to 
know if there is a patch to osl.c for kernel 2.4.24 made available? If 
there isn't one, then I can always use the initrd patch which I am using 
at the moment. I am not sure which method is the best though.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

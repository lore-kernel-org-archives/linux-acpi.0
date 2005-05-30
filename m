From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Mon, 30 May 2005 15:01:47 +0200
Message-ID: <20050530130147.GH32472@poupinou.org>
References: <1117244104.21648.1.camel@localhost.localdomain> <20050528101450.GA19354@fingerbrecher> <1117397912.24721.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1117397912.24721.5.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Cc: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, May 29, 2005 at 01:18:32PM -0700, James Sparenberg wrote:
> Ok Laptop in question is an Acer Aspire 3000 which other than acpi
> hardware is 100% (nice feeling)  Rather than put up all of the errors
> I'll break them into 3 groups.
> 
> 1.  1094 error (which I've a feeling if I fix others will follow) of
> which there are 3 types. 
> 
>       dsdt.dsl   743:                     0x0100, 0x00,,)
>       Error    1094 -                                   ^ Missing
> ResourceSource string (required)
> 
>       dsdt.dsl   750:                     , AddressRangeMemory,
> TypeStatic)
>       Error    1094 -            Missing ResourceSource string
> (required) ^
> 
> The second one I have about 20 of .... each time the Add........ line
> appears so one fix style should get me.


I suspect your iasl is broken somehow: a ResourceSource string is optional.

> 2.  The other errors I'm not finding docs on are related to PPC 
> 
>       dsdt.dsl  2506:                             If (LNot (LEqual
> (\_PR.CPU0._PPC, 0x00)))
>       Error    1022 -                                      Object does
> not exist ^               (\_PR.CPU0._PPC)
> 
>       dsdt.dsl  2508:                                 Store (0x00,
> \_PR.CPU0._PPC)
>       Error    1022 -                                     Object does
> not exist ^  (\_PR.CPU0._PPC)
> 
>       dsdt.dsl  2516:                             If (LLess
> (\_PR.CPU0._PPC, Local1))
>       Error    1022 -                               Object does not
> exist ^  (\_PR.CPU0._PPC)
> 
> There are about 10 of these.

This node is likely defined under another ACPI table called SSDT.
Please get ACPI spec from www.acpi.info but only if you are curious
about SSDT and the like..

I will check this but I need a full ACPI dump.

Could you please send a web link or, if you can not, send to me
privately the output from acpidmp after doing something like that:

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

I will also check if I'm correct with point 1.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

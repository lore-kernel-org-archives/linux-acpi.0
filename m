From: "Matthew Tippett" <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Fri, 13 Dec 2002 13:14:44 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFA2394.40806@casero.com>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B9AB@orsmsx107.jf.intel.com> <20021213171815.GS5382@whisky.intra.cprm.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021213171815.GS5382-V9yvzcrGID8XxY44YfPCZCanxOoIfzq+@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: chbm-tNiY1ywYjSU@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Carlos Morgado wrote:
> 
> On 2002.12.13 16:22:43 +0000 "Moore, Robert" wrote:
> 
>>
>> What is really being proposed here is for Linux ACPI to be
bug-for-bug
>> compatible with Microsoft.  This is impossible to do
deterministically
>> because the MS interpreter is closed source.  The only standard that 
>> we have
>> that we can code to is the ACPI specification, and this has to be the
>> last
>> word on the matter.
>>
> 
> not to mention windows tends to ignore builtin dsdts afaik and use the
ones
> distributed in windows drivers.

Continuing with this thread, would it make sense to be ACPI compliant 
but allow 'custom' dsdts to be passed to the acpi subsystem to allow 
users to work around less than perfect implementations from
manufacturers.

Although I am not as clued into the inner workings of ACPI, it may be 
extensible to allow developers to highlight to manufacturers where there
dstd is broken and how to have it fixed.

Regards,

Matthew


-----

The information contained in this message is proprietary of Casero Inc.,
protected from disclosure, and may be privileged. The information is
intended to be conveyed only to the designated recipient(s) of the
message. If the reader of this message is not the intended recipient,
you are hereby notified that any dissemination, use, distribution or
copying of this communication is strictly prohibited and may be
unlawful. If you have received this communication in error, please
notify us immediately by replying to the message and deleting it from
your computer. Thank you.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Presario 2701US and Battery info
Date: Wed, 7 Aug 2002 17:46:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807164612.GA16782@clara.net>
References: <D8C1802AADD0D346BE5C0A1D117075CC02C1C9F0@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <D8C1802AADD0D346BE5C0A1D117075CC02C1C9F0-pKAD8otJBe2P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Black, Richard [Richard.Black-VXdhtT5mjnY@public.gmane.org] wrote:
> No battery info (battery not present) on Presario 2701US
> 
> grep dsutils
>  dsutils-0391 [23] Ds_create_operand     : Object name [\_SB_.OKEC] was not found in namespace
>  dsutils-0554 [22] Ds_create_operands    : While creating Arg 2 - AE_AML_NAME_NOT_FOUND
>  dsutils-0391 [27] Ds_create_operand     : Object name [\_SB_.ACOK] was not found in namespace
>  dsutils-0554 [26] Ds_create_operands    : While creating Arg 1 - AE_AML_NAME_NOT_FOUND
>  dsutils-0391 [28] Ds_create_operand     : Object name [\_SB_.OKEC] was not found in namespace
>  dsutils-0391 [24] Ds_create_operand     : Object name [\_SB_.ACOK] was not found in namespace
>  dsutils-0554 [23] Ds_create_operands    : While creating Arg 2 - AE_AML_NAME_NOT_FOUND

This is why.  You haven't changed _SB_ to \_SB_ in your DSDT so the
_SB_ stuff is going in the wrong place in the ACPI hierarchy.

Fix your DSDT and it will likely fix this.

You can probably use my DSDT, someone is using it with a 2720US.


Faye

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses
 (fwd)
Date: Tue, 21 Dec 2004 08:54:22 +0100
Message-ID: <41C7D6AE.2080703@dif.dk>
References: <F7DC2337C7631D4386A2DF6E8FB22B30024F6C4C@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30024F6C4C-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:
>  
> 
>>Parenthesis around returns statements were driving me crazy for quite
>>a long time -- return is not a function and I do not think it should
>>look as one. Could we get this applied?
> 
> 
> K&R-2 says "Parentheses are often used around the expression, but they
> are optional."
> 
> Groping around the kernel, it seems that about 10% of return statements
> use these optional parentheses.
> 
> If we modify these, are we going to modify the other 10,000 instances
> or is that what your other 29 patches do?
> 
I had originally planned to do just that, but people on LKML responded 
with "only submit such cleanups via maintainers who actually want them", 
so I gave up on most of it again and just created this one patch for 
Pavel when he asked for it.

-- 
Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

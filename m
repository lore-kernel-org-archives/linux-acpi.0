From: Matthew Tippett <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>
Subject: Re: ospmd or acpid
Date: Thu, 12 Dec 2002 10:48:13 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF8AFBD.1040200@casero.com>
References: <3DF8A5CF.1000909@casero.com> <004c01c2a2bc$d19bdf80$8cfa6386@TRINITY>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <004c01c2a2bc$d19bdf80$8cfa6386-naq7wT523jg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: Matthew Tippett <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks, you answered the question.

So I will be sticking with acpid until all the ACPI support for my 
system is under control ;).

Matt

Knut Neumann wrote:
>>Just a quick question regarding the user space daemons for ACPI.  There
>>is ospmd which is part of the acpi project, and there is acpid which is
>>a seperate project which Andrew is a member of both.
> 
> 
> Hmm...so what is your question? I assume you meant to ask which daemon to
> use, so if thats right read on:
> 
> While acpid already reached version 1.0 and is quite ready to use, ospmd is
> supposed to be better of the two but it is still under development - though
> actually no one is really working on it. When its done it should replace not
> only acpid but also apmd and it is thought to handle UPSes and other power
> related devices as well.
> 




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

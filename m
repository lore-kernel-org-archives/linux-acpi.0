From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: 2.6.9-rc2-mm4 freezes at boot: ACPI IRQ9 SCI
Date: Thu, 30 Sep 2004 12:39:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <415BE261.3000100@pca.it>
References: <415A721B.5060005@pca.it> <Pine.LNX.4.61.0409291157020.12406@gsf.ironcreek.net>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.61.0409291157020.12406-XiQj8ckOZSeysH1UfigpQV6hYfS7NtTn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 09/29/04 18:59, Andre Eisenbach wrote:
> On Wed, 29 Sep 2004, Luca Capello wrote:
>> So, I suppose this isn't an ACPI error, but I'm not sure. Solutions?
> No, this is not an ACPI error. It's a problem with the "Preempt big
> kernel lock" feature. Check a Linux Kernel Mailing List archive for the
> 2.6.9-rc2-mm4 announcement thread.
> 
> Ingo Molnar has replied to the announcement thread with a tiny patch
> which fixes this problem.
thank you for the explanation, Andre, I found the LKML 2.6.9-rc2-mm4
announcement [1] and Ingo Molnar's patch [2].

But actually I don't need 2.6.9-rc2-mm4 anymore, as 2.6.9-rc3 is out and
it contains the 'swsusp/pmdisk' merging (which is the reason I was
trying to use 2.6.9-rc2-mm4).

Thx, bye,
Gismo / Luca

[1] http://lkml.org/lkml/2004/9/26/98
[2] http://lkml.org/lkml/2004/9/27/237
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBW+JgVAp7Xm10JmkRAs6EAJ0eusvXn0BxYIaiWqg1uJ8a2/PneACdEIg4
RfruQlYwHtT4gN1YpXK9gu8=
=ZbKB
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: ACPI: kmemcheck: Caught 16-bit read from freed memory (f7c12ec6)
Date: Thu, 8 May 2008 08:31:14 +0200
Message-ID: <19f34abd0805072331i2a33ee7bl940d46c478cc62d9@mail.gmail.com>
References: <19f34abd0805060909q635d2d43j9414e5f179c9e22f@mail.gmail.com>
	 <84144f020805061338yd6e3declaf5ff9ca344c28ba@mail.gmail.com>
	 <19f34abd0805061346q4af7e4f8kd65009f8d3021d0e@mail.gmail.com>
	 <4820C56C.6070204@cs.helsinki.fi>
	 <19f34abd0805071221o236c8629ib184a4720f178e7b@mail.gmail.com>
	 <1210224923.22503.8.camel@minggr.sh.intel.com>
	 <19f34abd0805072305i19dc37bn3e13fbca4b6981e3@mail.gmail.com>
	 <1210227145.23183.7.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:62943 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbYEHGbP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2008 02:31:15 -0400
Received: by rv-out-0506.google.com with SMTP id l9so794723rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2008 23:31:14 -0700 (PDT)
In-Reply-To: <1210227145.23183.7.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

(Reworked to bottom-post style)

On Thu, May 8, 2008 at 8:12 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>  > though it is unlikely that it will help you more than looking at the
>  > code (or the report) will do.
>  >
>  > >  Thanks,
>  > >  Lin Ming
>  > >
>  > >  Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>  > >  ---
>  > >  diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/parser/psargs.c
>  > >  index f1e8bf6..ef55d24 100644
>  > >  --- a/drivers/acpi/parser/psargs.c
>  > >  +++ b/drivers/acpi/parser/psargs.c
>  > >  @@ -268,7 +268,7 @@ acpi_ps_get_next_namepath(struct acpi_walk_state
>  > >  *walk_state,
>  >
>  > >          */
>  > >         if (ACPI_SUCCESS(status) &&
>  > >             possible_method_call && (node->type == ACPI_TYPE_METHOD)) {
>  > >  -               if (walk_state->op->common.aml_opcode == AML_UNLOAD_OP) {
>  > >  +               if (walk_state->op && walk_state->op->common.aml_opcode ==
>  > >  AML_UNLOAD_OP) {
>  > >                         /*
>  > >                          * acpi_ps_get_next_namestring has increased the AML pointer,
>  > >                          * so we need to restore the saved AML pointer for method call.
>  >
>  > Also, noticing your change, I can see why it makes no difference:
>  > Pekka already found that it is walk_state->op that has the value of
>  > 0xf7c12ec6 (e.g. the pointer being dereferenced), so the test will
>  > still succeed.
>  >
>  > On the other hand, I have discovered what seems to be a deficiency in
>  > kmemcheck (i.e. it might be my fault entirely), so it is possible that
>  > the warning is bogus. Will send an update shortly.

Okay: The deficiency is that SLUB will use the first four bytes of
each allocation to store the so-called freepointer; this means that
these will always be marked "initialized" even though they might
belong to an allocation that has been freed. This should NOT affect
the genuineness of the warning, however note that an earlier error
might have passed unnoticed. In other words, it doesn't lead to false
positives.

>  On Thu, 2008-05-08 at 08:05 +0200, Vegard Nossum wrote:
>  > Hello,
>  >
>  > On Thu, May 8, 2008 at 7:35 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>  > > Here comes a simple patch that fixes the warning in my machine.
>  > >
>  > >  Vegard, would you please help to test it in your machine?
>  > >
>  >
>  > Thanks for the try, but unfortunately this does not solve the problem.
>
>  It's strange.
>  In my machine, without this patch the warning shows up
>  With this patch applied the waring goes away

Ah. That is strange indeed.

>  Would you please upload the acpidump file?

Which file is this or how can I produce it? Please tell me the exact
parameters to pass to the command line.

>  > Please note that kmemcheck is an patch to the kernel; without it you
>  > will never see the warning. You can pull it from
>  > git://git.kernel.org/pub/scm/linux/kernel/git/vegard/kmemcheck.git current
>
>  Yes, I pulled the kmemcheck tree.
>
>  BTW, I like the kmemcheck patch, it's very useful :) Great work :)
>
>  Lin Ming

Ahh, great. You got it working! Thanks :-D


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036

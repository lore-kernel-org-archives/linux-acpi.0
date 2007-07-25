From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Regression in 2.6.22-rc3 and newer - Kernel oops in acpi_processor_throttling-seq-show
Date: Wed, 25 Jul 2007 18:06:00 -0400
Message-ID: <46A7C948.8020204@redhat.com>
References: <46A7C66E.305@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbXGYWGF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 18:06:05 -0400
In-Reply-To: <46A7C66E.305@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, luming.yu@intel.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On 07/25/2007 05:53 PM, Larry Finger wrote:
> On an x86_64 system with an AMD Turion 64 X2 processor, I get the
> following kernel oops with any
> system later than 2.6.22-rc2:
> 

Fixed by this, just committed?

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3cc2649b879f0e83fd51b14c82bad5f8f208591e

...

--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -658,18 +658,20 @@ static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 		   pr->throttling.state_count - 1);
 
 	seq_puts(seq, "states:\n");
-	if (acpi_processor_get_throttling == acpi_processor_get_throttling_fadt)
+	if (pr->throttling.acpi_processor_get_throttling ==
+			acpi_processor_get_throttling_fadt) {
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
 				   (i == pr->throttling.state ? '*' : ' '), i,
 				   (pr->throttling.states[i].performance ? pr->
 				    throttling.states[i].performance / 10 : 0));
-	else
+	} else {
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
 				   (i == pr->throttling.state ? '*' : ' '), i,
 				   (int)pr->throttling.states_tss[i].
 				   freqpercentage);
+	}
 
       end:
 	return 0;

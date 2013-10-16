From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 0/9] Extended H/W error log driver
Date: Wed, 16 Oct 2013 09:49:35 -0700
Message-ID: <1381942175.22110.57.camel@joe-AO722>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	 <20131016160550.GG13608@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:50851 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759389Ab3JPQti (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 12:49:38 -0400
In-Reply-To: <20131016160550.GG13608@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2013-10-16 at 18:05 +0200, Borislav Petkov wrote:
> On Wed, Oct 16, 2013 at 10:55:57AM -0400, Chen, Gong wrote:
[]
> > After applying this patch series, when a memory corrected error happens,
> > we can get following information:
> > 
> > dmesg output:
> > 
> > [  949.545817] {1}Hardware error detected on CPU15
> > [  949.549786] {1}event severity: corrected
> > [  949.549786] {1} Error 0, type: corrected
> > [  949.549786] {1}  section_type: memory error
> > [  949.549786] {1}  physical_address: 0x0000001057eb0000
> > [  949.549786] {1}  DIMM location: Memriser3 CHANNEL A DIMM 0
> > [  949.549786] {1}Above error has been corrected by h/w and require no further action
> > [  949.549786] mce: [Hardware Error]: Machine check events logged

> Yep, looks almost very good. One nit: can you raise the action line
> higher, like this:
> 
> > [  949.545817] {1}Hardware error detected on CPU15
> > [  949.549786] {1}It has been corrected by h/w and requires no further action
> 
> <here come the error details>

Perhaps this would be nicer still with the "mce:" prefix
on all the log lines with the overall description emitted
first.  It could help make grepping the log a bit easier.

[  xxx.xxxxxx] mce: [Hardware Error]: Machine check events logged
[  xxx.xxxxxx] mce: {1}Hardware error detected on CPU15
[  xxx.xxxxxx] mce: {1}Above error has been corrected by h/w and require no further action
[  xxx.xxxxxx] mce: {1}event severity: corrected
[  xxx.xxxxxx] mce: {1} Error 0, type: corrected
[  xxx.xxxxxx] mce: {1}  section_type: memory error
[  xxx.xxxxxx] mce: {1}  physical_address: 0x0000001057eb0000
[  xxx.xxxxxx] mce: {1}  DIMM location: Memriser3 CHANNEL A DIMM 0

grammar: s/require/requires or maybe required



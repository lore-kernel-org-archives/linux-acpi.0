From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: What's happening with the cpuidle code?
Date: Tue, 04 Sep 2007 18:15:59 -0400
Message-ID: <46DDD91F.3050004@redhat.com>
References: <46DDC462.2040309@redhat.com> <200709041743.47837.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbXIDWQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Sep 2007 18:16:18 -0400
In-Reply-To: <200709041743.47837.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Adam Belay <abelay@novell.com>

On 09/04/2007 05:43 PM, Len Brown wrote:
> On Tuesday 04 September 2007 16:47, Chuck Ebbert wrote:
>> A look at the 'cpuidle' branch of git-acpi shows a commit
>> e40cede7d63a029e92712a3fe02faee60cc38fb4, "cpuidle: first
>> round of documentation updates" that doesn't show up in that
>> branch online. The entire Documentation/cpuidle directory
>> is missing from the tree when looking at the web pages, and
>> it's missing from git-acpi.patch in 2.6.23-rc4-mm1 (but the
>> patch shows up in the summary information in the patch
>> header.) Where did it go? And how can -mm be used to test
>> things if its patches don't even match their own headers?
> 
> A later patch in that series, "cpuidle: re-write", reverted
> the documentation from the intermediate patch that you refer to:
> 
> http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=2305a5920fb8ee6ccec1c62ade05aa8351091d71

It never occurred to me that a patch would just remove documentation.
Thanks for looking into that...


From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 13:44:28 -0500
Message-ID: <20060302184428.GB7304@redhat.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com> <20060302083038.A11407@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:64159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751660AbWCBSof (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 13:44:35 -0500
Content-Disposition: inline
In-Reply-To: <20060302083038.A11407@unix-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Mar 02, 2006 at 08:30:38AM -0800, Ashok Raj wrote:


 > Could you see what comes out of the /proc/acpi/processor/CPUx/info for all the
 > 3 listed in your system?

I thought I already posted that..

(13:43:44:davej@nemesis:~)$ cat /proc/acpi/processor/CPU*/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
processor id:            1
acpi id:                 2
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
processor id:            255
acpi id:                 3
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no


 > Also if you can send DSDT dump just to look over.

http://people.redhat.com/davej/dsdt

		Dave


From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Wed, 1 Mar 2006 22:45:01 -0500
Message-ID: <20060302034501.GA29423@redhat.com>
References: <20060301224647.GD1440@redhat.com> <200603020238.31639.ak@suse.de> <20060302031348.GE19755@redhat.com> <200603020424.42500.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:14777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932451AbWCBDpW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 22:45:22 -0500
Content-Disposition: inline
In-Reply-To: <200603020424.42500.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>

On Thu, Mar 02, 2006 at 04:24:41AM +0100, Andi Kleen wrote:

 > > Why ACPI decides to create 3 processor entries is still odd though.
 > 
 > It should be four.

Then I guess the ACPI guys have an off-by-one bug somewhere ;)

		Dave

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] acpi: Fix warning: 'num_cpus' may be used
 uninitialized in this function
Date: Sat, 11 Sep 2010 13:40:37 -0300
Message-ID: <20100911164037.GB12989@khazad-dum.debian.net>
References: <20100911062254.GA18705@mail.gmail.com>
 <20100911062437.GA18711@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43690 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752394Ab0IKQqW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Sep 2010 12:46:22 -0400
Content-Disposition: inline
In-Reply-To: <20100911062437.GA18711@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Sacren <sakiwit@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Sat, 11 Sep 2010, Jean Sacren wrote:
> warning: 'num_cpus' may be used uninitialized in this function
> 
> Initialize 'num_cpus' variable to zero so that gcc doesn't complain.

acpi_pad_pur() is referenced only once, so it should end up inlined, at
which point gcc really has no excuse to not determine with perfect
confidence whether num_cpus is being used unitialized or not.

Looking at the code, it realy does look like a false positive.

Are you using a recent gcc?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 8/8] ACPI: DMI blacklist to reduce console warnings on OSI(Linux) systems.
Date: Thu, 24 Jan 2008 04:54:42 +0000
Message-ID: <200801240454.42732.carlos@strangeworlds.co.uk>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org> <200801240255.15294.carlos@strangeworlds.co.uk> <200801232335.03453.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:38423 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbYAXEyp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 23:54:45 -0500
In-Reply-To: <200801232335.03453.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thursday 24 January 2008 04:35:03 Len Brown wrote:
> I'm surprised to discover it uses strstr() and matches
> substrings instead.  Is there logic behind that?

As for the exact reason, no idea - you'd have to ask whoever is responsible 
for that. It's just a curious thing I've noticed and has come in rather 
handy.

As a side effect though, it does avoid lots of nasty unpleasantness with 
vendor whitespace padding abuse.

Otherwise, as Acer in particular love to pad many of their DMI entries with 
whitespace, we'd be scratching our heads forever as to why an entry doesn't 
work if we slip up and miss a whitespace character or two.

So at least from my perspective, substring matching is a good thing.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

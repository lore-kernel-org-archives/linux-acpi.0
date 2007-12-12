From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Wed, 12 Dec 2007 17:26:52 +0000
Message-ID: <200712121726.53180.carlos@strangeworlds.co.uk>
References: <200711280350.08539.carlos@strangeworlds.co.uk> <200712121410.15587.carlos@strangeworlds.co.uk> <476001E4.9020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:44739 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXLLR23 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 12:28:29 -0500
In-Reply-To: <476001E4.9020900@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Alexey,

Is the code in EC0 interfering then with the EC access code in AMW0? (See 
lines 962 onwards for the AMW0 EmbeddedControl region bits)?

Because AFAICT, the EC0 code is fine (my 5020 has the same AML for EC0 and 
doesn't have any problem, and the user didn't report any other EC problems - 
we only see this problem when we try to use the EmbeddedControl region in 
AMW0).

-Carlos

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

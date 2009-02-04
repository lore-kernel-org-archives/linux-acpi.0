From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Wed, 4 Feb 2009 12:00:43 -0800
Message-ID: <86802c440902041200k402699b7ibd2f7664cc59b509@mail.gmail.com>
References: <1233765552.16414.6.camel@localhost.localdomain>
	 <4989CB58.5000509@myri.com>
	 <9ae48b020902040937q15d8c158s86fbc358d03ee0ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:41712 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbZBDUAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 15:00:45 -0500
In-Reply-To: <9ae48b020902040937q15d8c158s86fbc358d03ee0ef@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: Loic Prylli <loic@myri.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org

On Wed, Feb 4, 2009 at 9:37 AM, Ed Swierk <eswierk@aristanetworks.com> wrote:
> On Wed, Feb 4, 2009 at 9:07 AM, Loic Prylli <loic@myri.com> wrote:
>> Minor question: there are motherboards with two MCP55 southbridges. Would
>> the patch support mmconfig for both?
>
> Can you point me to such a motherboard? I have only seen boards with
> one MCP55 plus a C51 companion chip providing extra PCIe lanes.
>
nvidia CRB

YH

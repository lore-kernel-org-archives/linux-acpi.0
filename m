From: Ed Swierk <eswierk@aristanetworks.com>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Wed, 4 Feb 2009 09:37:37 -0800
Message-ID: <9ae48b020902040937q15d8c158s86fbc358d03ee0ef@mail.gmail.com>
References: <1233765552.16414.6.camel@localhost.localdomain>
	 <4989CB58.5000509@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4989CB58.5000509@myri.com>
Sender: linux-pci-owner@vger.kernel.org
To: Loic Prylli <loic@myri.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 4, 2009 at 9:07 AM, Loic Prylli <loic@myri.com> wrote:
> Minor question: there are motherboards with two MCP55 southbridges. Would
> the patch support mmconfig for both?

Can you point me to such a motherboard? I have only seen boards with
one MCP55 plus a C51 companion chip providing extra PCIe lanes.

--Ed

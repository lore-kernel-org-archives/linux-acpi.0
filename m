From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 12:17:12 -0700
Message-ID: <CAE9FiQWuxJC8j8L6hwbuQk6k2pn1yvDO789MH0=E8MWm0t29_A@mail.gmail.com>
References: <20110923165946.27079.95660.stgit@bhelgaas.mtv.corp.google.com>
	<CAErSpo4LWWFrvRxtm8juQcxnaq8+citS4=1PV0edhLhzm=5yKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4LWWFrvRxtm8juQcxnaq8+citS4=1PV0edhLhzm=5yKw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 17, 2011 at 9:30 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Sep 23, 2011 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> If we're not using _CRS, the host bridge's bus name and resource str=
uctures
>> were allocated but never freed. =A0This patch fixes that.
>>
>> Patch by Catalin Marinas <catalin.marinas@arm.com>
>>
>> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
>> Reported-by: Simon Kirby <sim@hostway.ca>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

is this patch from you or Catalin?

If it is from Catalin, you should use

=46rom:  Catalin Marinas <catalin.marinas@arm.com>

Yinghai

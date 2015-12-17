From: sasa bogicevic <brutallesale@gmail.com>
Subject: Re: [PATCH 1/1] drivers:pci:hotplug Fix all whitespace issues
Date: Thu, 17 Dec 2015 22:57:28 +0100
Message-ID: <39E49061-F38F-478B-A83E-89FFD8553B78@gmail.com>
References: <1449849824-100004-1-git-send-email-brutallesale@gmail.com> <20151217215517.GA4864@localhost>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151217215517.GA4864@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lenb@kernel.org, scott@spiteful.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Sure thing, back to the laboratory :)
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 17, 2015, at 22:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> Hi Bogicevic,
> 
> On Fri, Dec 11, 2015 at 08:03:44AM -0800, Bogicevic Sasa wrote:
>> This fixes all sorts of whitespace errors and warnings as
>> well as blank line required after declaration messages in
>> drivers/pci/hotplug folder
> 
> 1) Can you combine drivers/pci/hotplug with drivers/pci in a single
> patch?
> 
> 2) Can you run objdiff on an allyesconfig build to make sure nothing
> really changed, and mention this in the changelog as you did with one
> of your others?  This might require moving the blank line
> additions/removals to a separate patch because those might change
> debug info or line numbers in printk messages.
> 
> Bjorn

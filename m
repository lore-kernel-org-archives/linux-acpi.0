From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Date: Sat, 30 Jun 2018 00:26:06 +0200
Message-ID: <20180629222606.GA4317@wunner.de>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 29, 2018 at 03:27:39PM -0500, Bjorn Helgaas wrote:
> +  - Wrap changelogs to fit in 80 columns when shown by "git show", which
> +    adds 4 spaces.  I use "textwidth=75" in vim.

I guess the ideal width is subjective, I usually wrap at 72 chars because
then you've got 4 blanks on either side when viewed with "git log", which
I find neater than maxing out the horizontal width.

In some cases I deliberately wrap at less than 72 chars or allow 73 chars
if it avoids vastly unequal widths in a paragraph.  Often when I later
doublecheck what you've committed, I find that you've rewrapped everything
to 75 chars and the result doesn't look as neat as I wanted it to be.
Not a big deal, but thought I'd mention it now that you're codifying this
"rule" somewhat more formally.

Lukas

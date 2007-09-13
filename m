From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] module to support ACPI AML calls to native firmware
Date: Thu, 13 Sep 2007 17:11:14 -0600
Message-ID: <200709131711.15015.bjorn.helgaas@hp.com>
References: <200709111714.57095.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200709111714.57095.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-ia64-owner@vger.kernel.org
To: linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 11 September 2007 05:14:56 pm Bjorn Helgaas wrote:
> ...
> So I'm interested in feedback on the following patches, which do not
> export sal_lock, but rather export functions that can be used to call
> SAL or other native firmware interfaces.

Hi Tony,

I haven't heard much feedback, and I couldn't come up with any
significantly better text for the description.

If you don't object to the two patches, can you incorporate them
as originally posted?  If you'd prefer a different approach, I'd
be happy to rework them, of course.

Thanks,
  Bjorn

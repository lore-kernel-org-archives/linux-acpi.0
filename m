From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5 -v2] acpi, apei, APEI supporting infrastructure
Date: Fri, 18 Dec 2009 19:11:23 +0100
Message-ID: <20091218181123.GA1470@ucw.cz>
References: <1260429417.15264.394.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932433AbZLRSLl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260429417.15264.394.camel@yhuang-dev.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu 2009-12-10 15:16:57, Huang Ying wrote:
> APEI stands for ACPI Platform Error Interface, which allows to report
> errors (for example from the chipset) to the operating system. This
> improves NMI handling especially. In addition it supports error
> serialization and error injection.
> 
> For more information about APEI, please refer to ACPI Specification
> version 4.0, chapter 17.
> 
> This patch provides some common functions used by more than one APEI
> tables, mainly framework of interpreter for EINJ and ERST.
> 
> A machine readable language is defined for EINJ and ERST for OS to
> execute, and so to drive the firmware to fulfill the corresponding
> functions. The machine language for EINJ and ERST is compatible, so a
> common framework is defined for them.

Does this mean we'll now try to run acpi interrpretter from NMI
context?

I don't see how that can work; NMI is really special... 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

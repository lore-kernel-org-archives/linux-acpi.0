From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ACPI] IDE failure on ACPI resume
Date: Thu, 17 Mar 2005 15:10:21 +0000
Message-ID: <1111072221.8136.171.camel@tyrosine>
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <423518E7.3030300@root.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Lawson <nate@root.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-03-13 at 20:53 -0800, Nate Lawson wrote:

> Sounds like PCI not being completely restored.  We had to work around 
> some weird ATA issues in FreeBSD with the status register being invalid 
> for quite a while after resume.  A retry loop was the solution.

FreeBSD seems to fail in the same way on the same hardware,
unfortunately. I'm leaning towards suspecting that we need to be doing
something with the contents of the _GTF method, but by the looks of that
that requires us to be able to work out which methods correspond to
which hardware. Is anyone working on implementing this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

From: Nate Lawson <nate@root.org>
Subject: Re: [ACPI] IDE failure on ACPI resume
Date: Thu, 17 Mar 2005 12:34:02 -0800
Message-ID: <4239E9BA.7050105@root.org>
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org> <1111072221.8136.171.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111072221.8136.171.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Sun, 2005-03-13 at 20:53 -0800, Nate Lawson wrote:
> 
> 
>>Sounds like PCI not being completely restored.  We had to work around 
>>some weird ATA issues in FreeBSD with the status register being invalid 
>>for quite a while after resume.  A retry loop was the solution.
> 
> 
> FreeBSD seems to fail in the same way on the same hardware,
> unfortunately. I'm leaning towards suspecting that we need to be doing
> something with the contents of the _GTF method, but by the looks of that
> that requires us to be able to work out which methods correspond to
> which hardware. Is anyone working on implementing this?
> 

Very interesting.  I was hoping to someday have _GTF et al implemented 
but the ATA knowledge required was above my head.  I also strongly 
suspected that the info published by _GTF would likely be invalid.  Does 
Windows actually use that method or just hardcoded ATA initialization?

-- 
Nate

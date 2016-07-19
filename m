From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V10 4/9] vfio: platform: add support for ACPI probe
Date: Tue, 19 Jul 2016 09:28:19 -0600
Message-ID: <20160719092819.0334c607@t450s.home>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
	<1468883367-2854-5-git-send-email-okaya@codeaurora.org>
	<20160718180049.78db3dfb@t450s.home>
	<b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
	<20160718182448.7b11a7af@t450s.home>
	<73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
Sender: kvm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 19 Jul 2016 10:49:54 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 7/18/2016 8:24 PM, Alex Williamson wrote:
> >>> nit, might make sense to replace EPERM with ENOENT and use EINVAL here.  
> >>> > >     
> >> > 
> >> > Sure, will take carr of it.
> >> > 
> >> > Anything else I need to take care of?  
> > Not that I see, maybe just send a new version of this patch if the
> > changes don't trickle through too much.  Thanks,  
> 
> I posted V11 with the discussed change. 
> 
> [PATCH V11 0/9] vfio, platform: add ACPI support
> 
> Do you see this making to 4.8 kernel?


I hope so, I'll try to get it into my next branch within the next day
or so.  Thanks,

Alex

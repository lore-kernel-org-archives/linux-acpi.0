From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop on VAIO TT help request
Date: Thu, 30 Jun 2011 22:55:09 +0900
Message-ID: <20110630135507.GA24186@kamineko.org>
References: <4E0C4AE2.2050706@fnarfbargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E0C4AE2.2050706@fnarfbargle.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Brad Campbell <lists2009@fnarfbargle.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 30, 2011 at 06:07:30PM +0800, Brad Campbell wrote:
> G'day all,
> 
> I have a sony Vaio TT notebook. It works reasonably well with the
> sony-laptop kernel module excepting the following items
> 
> - No control over the optical drive power state
> - No control over the "battery care" function in the embedded controller
> - No control over the "quick charge" function
> 
> All three of these functions are sub-functions of the SNY6001 method
> call, just the same as the rfkill functions.
> 
> I've reverse engineered all three of them with the assistance of
> some damaged windows drivers and software. I'd like to add these
> functions into the sony-laptop module, but I've absolutely no idea
> where to start.

there are patches already floating around, you can take a look here
http://www.absence.it/vaio-acpi/source/patches/
the code is making its way into the kernel.

ciao
-- 
mattia
:wq!

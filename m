From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH 2/2] ACPI video: add initial blacklist to use vendor
 drivers for backlight
Date: Tue, 18 Jan 2011 17:24:57 -0200
Message-ID: <20110118172457.600e8974@gotham.conectiva>
References: <1295376114-5685-1-git-send-email-herton@mandriva.com.br>
	<1295376114-5685-2-git-send-email-herton@mandriva.com.br>
	<20110118185659.GA29173@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110118185659.GA29173@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 18 Jan 2011 18:56:59 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Jan 18, 2011 at 04:41:54PM -0200, Herton Ronaldo Krzesinski wrote:
> 
> > This adds a list for shuttle devices I tested which doesn't have working
> > backlight support in acpi video, but works with workaround done in
> > shuttle-wmi driver, so for them, add dmi blacklist to use vendor driver.
> 
> How about a hook to call from the shuttle-wmi driver to disable it? That 
> way we wouldn't need the blacklist in the ACPI driver.

The problem is that acpi video driver needs to know the blacklist before it
registers its backlight class, not possible to do at run time (eg., disabling
it after video.ko is loaded). I don't know if there is a good solution to
this, besides adding this blacklist in video module.

> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

--
[]'s
Herton

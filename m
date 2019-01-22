From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] acpi: no need to check return value of debugfs_create
 functions
Date: Tue, 22 Jan 2019 16:40:10 +0100
Message-ID: <20190122154010.GA19652@kroah.com>
References: <20190122152151.16139-4-gregkh@linuxfoundation.org>
 <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Yangtao Li <tiny.windzz@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 22, 2019 at 04:28:42PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 22, 2019 at 4:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Yangtao Li <tiny.windzz@gmail.com>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or do you want me to take this?

It's up to you, I can take it, or you can, either is fine with me :)

greg k-h

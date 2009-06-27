From: Alex Chiang <achiang@hp.com>
Subject: Re: [2.6.31-rc1] oops in acpi_get_pci_dev
Date: Sat, 27 Jun 2009 12:55:22 -0600
Message-ID: <20090627185522.GA24569@ldl.fc.hp.com>
References: <5a4c581d0906250325q1dd9ca67na9a8c7ecbffe4897@mail.gmail.com> <20090624150217.GD1512@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757369AbZF0Sz1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090624150217.GD1512@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>, linux-kernel@vger.kernel.org, ACPI mailing list <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

* Pavel Machek <pavel@ucw.cz>:
> 
> I had similar oops here, too, on thinkpad x60. It is interesting: most
> breakage seems to happen just before -rc1...

Already fixed in Linus's tree.

Thanks.

/ac

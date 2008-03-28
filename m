From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] Introduce pci_slot
Date: Fri, 28 Mar 2008 10:56:49 -0700
Message-ID: <20080328105649.dd716d06.akpm@linux-foundation.org>
References: <20080325041314.GA29666@ldl.fc.hp.com>
	<20080325041700.GD29666@ldl.fc.hp.com>
	<20080328033939.5ef5ab7b.akpm@linux-foundation.org>
	<20080328154139.GE17862@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756410AbYC1SA2@vger.kernel.org>
In-Reply-To: <20080328154139.GE17862@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Mar 2008 09:41:39 -0600 Alex Chiang <achiang@hp.com> wrote:

> In the future, do you have a better suggestion on how to do large
> sweeps on code for hardware that one might not own? Is there an
> easier way other than setting up a cross-compiler environment?

Setting up a cross-compile environment is easy -
http://userweb.kernel.org/~akpm/cross-compilers/ has several.

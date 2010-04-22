From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pci: Ensure we re-enable devices on resume
Date: Thu, 22 Apr 2010 16:17:35 -0700
Message-ID: <20100422161735.28dcc8b9@virtuousgeek.org>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1271943051-2671-1-git-send-email-mjg@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, achiang@canonical.com, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 Apr 2010 09:30:51 -0400
Matthew Garrett <mjg@redhat.com> wrote:

> If the firmware puts a device back into D0 state at resume time, we'll
> update its state in resume_noirq and thus skip the platform resume code.
> Calling that code twice should be safe and we ought to avoid getting to
> that point anyway, so remove the check and also allow the platform pci
> code to be called for D0.
> 
> Fixes USB not being powered after resume on recent Lenovo machines.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---

Applied to for-linus, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center

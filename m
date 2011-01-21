From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/5] i915: Add native backlight control
Date: Fri, 21 Jan 2011 04:57:54 +0000
Message-ID: <20110121045754.GA9897@srcf.ucam.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-2-git-send-email-mjg@redhat.com>
	<20112101000015@lilem.mirepesht> <20112101004346@lilem.mirepesht>
	<20110120151349.49cf3ebb.akpm@linux-foundation.org>
	<20110121004359.GA6422@srcf.ucam.org>
	<20110120170337.94d83333.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20110120170337.94d83333.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 20, 2011 at 05:03:37PM -0800, Andrew Morton wrote:
> I updated the new drivers/video/backlight/adp5520_bl.c, but there's a
> decent chance that unconverted drivers will sneak in.  I trust they
> will still work OK?

They should fire a warning on registration but otherwise work. I'll send 
fixup patches for any I see.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

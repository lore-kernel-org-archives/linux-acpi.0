From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [3.9-rc1] irq 16: nobody cared (was [3.9-rc1] very poor interrupt
	responses)
Date: Sun, 17 Mar 2013 22:41:28 -0400
Message-ID: <2654053.iVVmfUEvRC@segfault.sh0n.net>
References: <Pine.LNX.4.44L0.1303141050310.1983-100000@iolanthe.rowland.org>
	<alpine.LNX.2.00.1303151609480.9529@pobox.suse.cz>
	<CAE9FiQUqPTUqPOzANnxpdfoRYPr+OiU5pFEoLKRiOFHd9Py4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968175004=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAE9FiQUqPTUqPOzANnxpdfoRYPr+OiU5pFEoLKRiOFHd9Py4XQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Harald Arnesen <skogtun.linux@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Jiri Kosina <jkosina@suse.cz>, Daniel Vetter <daniel.vetter@ffwll.ch>, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Thomas Meyer <thomas@m3y3r.de>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--===============0968175004==
Content-Type: multipart/alternative; boundary="nextPart7883118.HHc0sZQR6G"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart7883118.HHc0sZQR6G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 15, 2013 12:14:28 PM Yinghai Lu wrote:
> On Fri, Mar 15, 2013 at 8:14 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> > Just a datapoint -- I have put a trivial debugging patch in place, and it
> > reveals that "nobody cared" for irq 16 happens long after last
> > 
> >         I915_WRITE(GMBUS4 + reg_offset, 0);
> > 
> > has been performed in gmbus_wait_hw_status(). On the other hand, if I
> > comment out both GMBUS4 register offset writes in gmbus_wait_hw_status(),
> > then it of course falls back to GPIO bit-banging, but the "nobody cared"
> > for irq 16 is gone.
> > 
> > So it seems like something gets severely confused by the I915_WRITE to
> > GMBUS4 + reg_offset. So far this seems to have been reported solely on
> > Lenovos as far as I can see (although a completely different types), so it
> > might be some platform-specific quirk?
> > 
> > Honestly, I still don't understand how all the GMBUS stuff relates to IRQ
> > 16 at all.
> 
> that device is using
> i915 0000:00:02.0: irq 44 for MSI/MSI-X
> 
> so can you try to boot with pci=nomsi?

I can try disabling MSI with 3.9.0-0.rc2.git0.4.fc20. -rc3 is not yet 
available in rawhide.

thanks,
Shawn
--nextPart7883118.HHc0sZQR6G
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Monospace'; font-size:9pt; font-weight:600; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Friday, March 15, 2013 12:14:28 PM Yinghai Lu wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On Fri, Mar 15, 2013 at 8:14 AM, Jiri Kosina &lt;jkosina@suse.cz&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Just a datapoint -- I have put a trivial debugging patch in place, and it</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; reveals that &quot;nobody cared&quot; for irq 16 happens long after last</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;         I915_WRITE(GMBUS4 + reg_offset, 0);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; has been performed in gmbus_wait_hw_status(). On the other hand, if I</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; comment out both GMBUS4 register offset writes in gmbus_wait_hw_status(),</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; then it of course falls back to GPIO bit-banging, but the &quot;nobody cared&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; for irq 16 is gone.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; So it seems like something gets severely confused by the I915_WRITE to</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; GMBUS4 + reg_offset. So far this seems to have been reported solely on</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Lenovos as far as I can see (although a completely different types), so it</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; might be some platform-specific quirk?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Honestly, I still don't understand how all the GMBUS stuff relates to IRQ</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; 16 at all.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; that device is using</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; i915 0000:00:02.0: irq 44 for MSI/MSI-X</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; so can you try to boot with pci=nomsi?</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I can try disabling MSI with 3.9.0-0.rc2.git0.4.fc20. -rc3 is not yet available in rawhide.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">thanks,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Shawn</p></body></html>
--nextPart7883118.HHc0sZQR6G--


--===============0968175004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0968175004==--

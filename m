From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/8] ACPI: video - more cleanups
Date: Wed, 14 Nov 2007 12:47:44 -0500
Message-ID: <200711141247.44425.lenb@kernel.org>
References: <20071105164328.982283020@anvil.corenet.prv> <1195024691.1262.48.camel@acpi-hp.sh.intel.com> <200711141242.06801.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35264 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbXKNRr6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 12:47:58 -0500
In-Reply-To: <200711141242.06801.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org


> > > -       printk("video bus notify\n");
> > > +       printk(KERN_DEBUG "video bus notify\n");
> > This debug message should be removed.
> 
> wups, yes I remember that one...
> I'll delete that in .24 and queue the rest of Dmitry's cleanup for .25.
> 

Hmmm, looks like another stray printk down below -- should I nuke that too?


static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
{
        struct acpi_video_bus *video = seq->private;
        unsigned long options;
        int status;


        if (!video)
                goto end;

        status = acpi_video_bus_POST_options(video, &options);
        if (ACPI_SUCCESS(status)) {
                if (!(options & 1)) {
                        printk(KERN_WARNING PREFIX
                               "The motherboard VGA device is not listed as a possible POST device.\n");
                        printk(KERN_WARNING PREFIX
                               "This indicates a BIOS bug. Please contact the manufacturer.\n");
                }
-->>>           printk("%lx\n", options);
                seq_printf(seq, "can POST: <integrated video>");
                if (options & 2)
                        seq_printf(seq, " <PCI video>");
                if (options & 4)
                        seq_printf(seq, " <AGP video>");
                seq_putc(seq, '\n');
        } else
                seq_printf(seq, "<not supported>\n");
      end:
        return 0;
}

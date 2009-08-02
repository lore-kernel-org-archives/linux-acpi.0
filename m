From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 3/4] thinkpad-acpi: Avoid heap buffer overrun
Date: Sun, 2 Aug 2009 11:53:06 +0200
Message-ID: <200908021153.06769.mb@bu3sch.de>
References: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br> <200908011754.51077.mb@bu3sch.de> <20090802015012.GA14889@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:57978 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbZHBJxf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Aug 2009 05:53:35 -0400
In-Reply-To: <20090802015012.GA14889@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, stable@kernel.org

On Sunday 02 August 2009 03:50:12 Henrique de Moraes Holschuh wrote:
> > Note that it turns out this is not a real-life bug after all.
> > The VFS code checks count for signedness (high bit set) and bails
> > out if this is the case.
> > Well, it might probably be a good idea to restrict the count range to
> > something sane here anyway, so...
> 
> It is a good idea to restrict the maximum size to something sane anyway.
> 
> But the commit message needs to be fixed if there is no security hole.
> 
> Anyway, in which function and file is the VFS code that restricts the
> maximum size?
> 

Well there are two things. It happens that access_ok() on x86 does such a
check. It does _not_ do this on all arches, but as a thinkpad is x86...
And there are sanity checks in fs/read_write.c:

208 /*
209  * rw_verify_area doesn't like huge counts. We limit
210  * them to something that fits in "int" so that others
211  * won't have to do range checks all the time.
212  */
213 #define MAX_RW_COUNT (INT_MAX & PAGE_CACHE_MASK)
214 
215 int rw_verify_area(int read_write, struct file *file, loff_t *ppos, size_t count)
216 {
217         struct inode *inode;
218         loff_t pos;
219         int retval = -EINVAL;
220 
221         inode = file->f_path.dentry->d_inode;
222         if (unlikely((ssize_t) count < 0))
223                 return retval;
224         pos = *ppos;
225         if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
226                 return retval;
227 
228         if (unlikely(inode->i_flock && mandatory_lock(inode))) {
229                 retval = locks_mandatory_area(
230                         read_write == READ ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE,
231                         inode, file, pos, count);
232                 if (retval < 0)
233                         return retval;
234         }
235         retval = security_file_permission(file,
236                                 read_write == READ ? MAY_READ : MAY_WRITE);
237         if (retval)
238                 return retval;
239         return count > MAX_RW_COUNT ? MAX_RW_COUNT : count;
240 }

-- 
Greetings, Michael.

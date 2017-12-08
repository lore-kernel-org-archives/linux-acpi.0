From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 3/4] x86/xen: fix boot loader version
	reported for pvh guests
Date: Fri,  8 Dec 2017 16:11:38 +0100
Message-ID: <20171208151139.30213-4-jgross@suse.com>
References: <20171208151139.30213-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20171208151139.30213-1-jgross@suse.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, corbet@lwn.net, rjw@rjwysocki.net, stable@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

VGhlIGJvb3QgbG9hZGVyIHZlcnNpb24gcmVwb3J0ZWQgdmlhIHN5c2ZzIGlzIHdyb25nIGluIGNh
c2Ugb2YgdGhlCmtlcm5lbCBiZWluZyBib290ZWQgdmlhIHRoZSBYZW4gUFZIIGJvb3QgZW50cnku
IGl0IHNob3VsZCBiZSAyLjEyCigweDAyMGMpLCBidXQgaXQgaXMgcmVwb3J0ZWQgdG8gYmUgMi4x
OCAoMHgwMjEyKS4KCkFzIHRoZSBjdXJyZW50IHdheSB0byBzZXQgdGhlIHZlcnNpb24gaXMgZXJy
b3IgcHJvbmUgdXNlIHRoZSBtb3JlCnJlYWRhYmxlIHZhcmlhbnQgKDIgPDwgOCkgfCAxMi4KCkNj
OiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0LjEyClNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KLS0tCiBhcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHZoLmMKaW5kZXggNDM2YzRmMDAzZTE3Li42ZTY0MzBjYjVlM2YgMTAwNjQ0Ci0t
LSBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHZoLmMKKysrIGIvYXJjaC94ODYveGVuL2VubGln
aHRlbl9wdmguYwpAQCAtNjksNyArNjksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW5pdF9wdmhf
Ym9vdHBhcmFtcyh2b2lkKQogCSAqIFZlcnNpb24gMi4xMiBzdXBwb3J0cyBYZW4gZW50cnkgcG9p
bnQgYnV0IHdlIHdpbGwgdXNlIGRlZmF1bHQgeDg2L1BDCiAJICogZW52aXJvbm1lbnQgKGkuZS4g
aGFyZHdhcmVfc3ViYXJjaCAwKS4KIAkgKi8KLQlwdmhfYm9vdHBhcmFtcy5oZHIudmVyc2lvbiA9
IDB4MjEyOworCXB2aF9ib290cGFyYW1zLmhkci52ZXJzaW9uID0gKDIgPDwgOCkgfCAxMjsKIAlw
dmhfYm9vdHBhcmFtcy5oZHIudHlwZV9vZl9sb2FkZXIgPSAoOSA8PCA0KSB8IDA7IC8qIFhlbiBs
b2FkZXIgKi8KIH0KIAotLSAKMi4xMi4zCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMu
eGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3hlbi1kZXZlbA==
